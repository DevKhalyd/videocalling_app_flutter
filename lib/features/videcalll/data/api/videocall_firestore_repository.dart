import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/repositories/firestore_repository.dart';
import '../../../../core/utils/logger.dart';
import '../../../home/domain/models/call.dart';

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
  /// [newState] is the new state of the call. Must be between `0 and 4`.
  ///
  /// Each method that uses this method must have a validation to works properly with the application architecture.
  Future<void> updateStateCall(String callId, int newState) async {
    assert(newState <= 4 && newState >= 0,
        'The range must be between 0 and 4. Check out the CallState model for further information');
    try {
      firestore.runTransaction((transaction) async {
        final documentReference = getDocumentReference(callsCollection, callId);
        DocumentSnapshot snapshot = await transaction.get(documentReference);

        if (!snapshot.exists) {
          Log.console('The reference to the document does not exist', L.E);
          return;
        }
        transaction.update(documentReference, {
          'callState.type': newState,
        });
        log('CallState.type was updated in firestore with the value $newState');
      });
    } catch (e) {
      rethrow;
    }
  }

  /// This is method is called when the call is ended and both users have interaction.
  ///
  /// [callId] is the id of the call (document)
  ///
  /// [newDuration] is the duration of the call in the format `00:00`
  Future<void> updateDurationCall(String callId, String newDuration) async {
    try {
      firestore.runTransaction((transaction) async {
        final documentReference = getDocumentReference(callsCollection, callId);
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        if (!snapshot.exists) {
          Log.console('The reference to this document does not exist', L.E);
          return;
        }

        final data = snapshot.data() as Map<String, dynamic>?;

        if (data == null) {
          Log.console('The data of this document is null', L.E);
          return;
        }

        final duration = data['duration'] as String?;

        if (duration?.isEmpty ?? true) {
          log('Updating with the new Duration of $newDuration');
          transaction.update(documentReference, {'duration': newDuration});
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}
