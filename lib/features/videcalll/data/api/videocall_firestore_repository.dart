import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/repositories/firestore_repository.dart';
import '../../../../core/utils/logger.dart';
import '../../../home/domain/models/call.dart';
import '../../../home/domain/models/call_state.dart';

class VideoCallFirestoreRepository extends FirestoreRepository {
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

  /// Run a transaction and update the current state of the call
  ///
  /// [callId] is the id of the call (document)
  ///
  /// [newState] is the new state of the call. Must be between `CallState.stateFinalized` and `CallState.stateLost`
  Future<void> updateStateCall(String callId, int newState) async {
    final newStateCondition =
        newState == CallState.stateFinalized || newState == CallState.stateLost;

    assert(newStateCondition, 'The states can be: stateFinalized or stateLost');

    try {
      firestore.runTransaction((transaction) async {
        final documentReference = getDocumentReference(callsCollection, callId);
        DocumentSnapshot snapshot = await transaction.get(documentReference);

        if (!snapshot.exists) {
          Log.console('The reference to the document does not exist', L.E);
          return;
        }

        /// The latest information about the call
        final call = Call.fromJson(snapshot.data() as Map<String, dynamic>);

        final state = call.callState.type;

        /// The call was updated already
        if (state > CallState.stateCalling) return;

        // NOTE: Might be a problem with the field to update
        transaction.update(documentReference, {
          'callState.type': newState,
        });
        log('CallState.type was updated in firestore with the value $newState');
      });
    } catch (e) {
      rethrow;
    }
  }
}
