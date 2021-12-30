import 'package:videocalling_app/core/utils/utils.dart';

import '../../../../core/utils/logger.dart';
import '../../data/api/chat_firestore_repository.dart';
import '../models/message.dart';

abstract class ListenConversation {
  /// [id] The id of this conversation
  static Stream<List<Message>> execute(String id) async* {
    try {
      final repo = ChatFirestoreRepository();
      // TODO: Get the messages by date...
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
