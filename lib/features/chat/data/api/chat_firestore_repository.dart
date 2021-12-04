import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/repositories/firestore_repository.dart';

class ChatFirestoreRepository extends FirestoreRepository {
  /// Listen to a user document
  ///
  /// [id] Document ID
  Stream<QuerySnapshot<Object?>> listenUser(String id) {
    try {
      final reference = getCollection('$usersCollection/$id');
      return getStream(reference);
    } catch (e) {
      rethrow;
    }
  }
}
