import '../../../../core/utils/utils.dart';
import '../../data/api/message_firestore_repository.dart';
import '../models/conversation.dart';

abstract class GetConversations {
  /// [id] of the current user
  static Stream<List<Conversation>> execute(String id) async* {
    try {
      final repo = MessageFirestoreRepository();
      final stream = repo.getConversations(id);

      await for (var s in stream) {
        final docs = s.docs;
        final list = <Conversation>[];

        if (docs.isEmpty) {
          yield list;
          return;
        }

        docs.forEach((doc) {
          final data = doc.data();
          final conversation =
              Conversation.fromJson(data as Map<String, dynamic>);
          list.add(conversation);
        });
        yield list;
      }
    } catch (e) {
      Utils.printACatch('GetConversations', e);
      Stream.value([]);
    }
  }
}
