import 'package:videocalling_app/features/calls/data/api/call_firestore_repository.dart';

abstract class CreateConversation {
  /// Create the conversation
  static Future<String> execute(List<String> ids) async {
    try {
      final repo = CallFirestoreRepository();
      return await repo.createConversation(ids);
    } catch (e) {
      rethrow;
    }
  }
}
