import '../../../../core/shared/models/user/user.dart';
import '../../../../core/utils/utils.dart';
import '../../data/api/chat_firestore_repository.dart';

abstract class ListenUser {
  /// [id] The id of the user to listen
  static Stream<User?> execute(String id) async* {
    try {
      final repo = ChatFirestoreRepository();

      final stream = repo.listenUser(id);

      await for (final doc in stream) {
        if (!doc.exists) {
          yield null;
          return;
        }
        yield User.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      Utils.printACatch('ListenUser', e);
      yield null;
    }
  }
}
