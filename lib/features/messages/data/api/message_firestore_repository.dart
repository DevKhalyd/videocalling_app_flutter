import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/repositories/firestore_repository.dart';

class MessageFirestoreRepository extends FirestoreRepository {
  /// Get the avaible conversations for this user
  Stream<QuerySnapshot<Object?>> getConversations(String idUser) {
    try {
      return getStream(_getCollectionReference(idUser));
    } catch (e) {
      rethrow;
    }
  }

  /// The references to the conversations for this user.
  CollectionReference _getCollectionReference(String idUser) {
    return getCollection('$usersCollection/$idUser/$conversationsCollection');
  }
}
