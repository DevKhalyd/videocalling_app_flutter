import '../../../../core/utils/utils.dart';
import '../../data/api/call_firestore_repository.dart';

abstract class GetIdConversation {
  /// Id of a unique conversation
  ///
  /// [ids] - Ids of the users
  ///
  /// Null if the conversation doesn't exist
  static Future<String?> execute(List<String> ids) async {
    try {
      final repo = CallFirestoreRepository();
      return await repo.getIdConversation(ids);
    } catch (e) {
      Utils.printACatch('GetIdConversation', e);
    }
  }
}
