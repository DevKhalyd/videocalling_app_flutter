import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/repositories/firestore_repository.dart';
import '../../../home/domain/models/call.dart';

class VideoCallRepository extends FirestoreRepository {
  /// Create a call in firestore
  Future<DocumentReference> createCall(Call call) async {
    try {
      return await addData(callsCollection, call.toJson());
    } catch (_) {
      rethrow;
    }
  }

  /// Helps to know the current state of the call and then update UI with those states
  Stream<DocumentSnapshot> listenCall(String callId) {
    try {
      return listenDocument(callsCollection, callId);
    } catch (e) {
      rethrow;
    }
  }
}
