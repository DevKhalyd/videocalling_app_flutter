import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/repositories/firestore_repository.dart';

class MessageFirestoreRepository extends FirestoreRepository {
  /// Get the avaible conversations for this user
  Stream<QuerySnapshot<Object?>> getConversations(String idUser) {
    try {
      return getStreamCollection(_getCollectionReference(idUser),
          // Nested search...
          field: 'lastMessage.$date');
    } catch (e) {
      rethrow;
    }
  }

  /// The references to the conversations for this user.
  CollectionReference _getCollectionReference(String idUser) {
    final collection = '$usersCollection/$idUser/$conversationsCollection';
    return getCollection(collection);
  }
}
