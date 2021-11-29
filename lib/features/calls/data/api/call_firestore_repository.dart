import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/repositories/firestore_repository.dart';

class CallFirestoreRepository extends FirestoreRepository {
  /// Return the history of calls of this user
  Stream<QuerySnapshot<Object?>> getHistoryCalls(String idDoc) {
    try {
      final historyCalls = '$usersCollection/$idDoc/$historyCallsCollection';
      return getCollection(historyCalls).snapshots();
    } catch (e) {
      rethrow;
    }
  }
}
