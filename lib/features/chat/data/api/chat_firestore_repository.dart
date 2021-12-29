import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/repositories/firestore_repository.dart';
import '../../domain/models/message.dart';

class ChatFirestoreRepository extends FirestoreRepository {
  /// Listen to a user
  ///
  /// [id] Document ID
  Stream<DocumentSnapshot<Object?>> listenUser(String id) {
    try {
      final reference = getCollection('$usersCollection').doc(id);
      return getStreamDocument(reference);
    } catch (e) {
      rethrow;
    }
  }

  /// [id] The id of the conversation
  Stream<QuerySnapshot<Object?>> listenConversation(String id) {
    try {
      final reference =
          getCollection('$conversationsCollection/$id/$messagesCollection');
      return getStreamCollection(reference);
    } catch (e) {
      rethrow;
    }
  }

  /// Create a new Message in a given conversation
  Future<void> sendMessage(
    String idConversation,
    Message message,
  ) async {
    try {
      final collection = getCollection(
          '$conversationsCollection/$idConversation/$messagesCollection');
      await collection.add(message.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
