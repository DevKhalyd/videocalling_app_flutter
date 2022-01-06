import 'package:videocalling_app/core/utils/utils.dart';
import 'package:videocalling_app/features/messages/domain/models/message_type.dart';

import '../../../../core/utils/logger.dart';
import '../../data/api/chat_firestore_repository.dart';
import '../models/message.dart';

abstract class ListenConversation {
  /// [id] The id of this conversation
  static Stream<List<Message>> execute(String id) async* {
    try {
      final repo = ChatFirestoreRepository();
      final stream = repo.listenConversation(id);
      await for (final q in stream) {
        final docs = q.docs;
        if (docs.isEmpty) {
          Log.console(
              'This conversation does not have messages or does not exists',
              L.W);
          yield [];
          return;
        }

        final messages = <Message>[];

        docs.forEach((d) {
          final data = d.data() as Map<String, dynamic>;
          final message = Message.fromJson(data);
          if (message.messageType.type != MessageType.initialMessage)
            messages.add(message);
        });
        yield messages;
      }
    } catch (e) {
      Utils.printACatch('ListenConversation', e);
      yield [];
    }
  }
}
