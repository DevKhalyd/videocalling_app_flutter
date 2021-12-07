import '../../data/api/call_firestore_repository.dart';

abstract class CreateConversation {
  /// Create the conversation
  ///
  /// [ids] The ids of the users in the conversation
  static Future<String> execute(List<String> ids) async {
    try {
      final repo = CallFirestoreRepository();
      return await repo.createConversation(ids);
    } catch (e) {
      rethrow;
    }
  }
}
