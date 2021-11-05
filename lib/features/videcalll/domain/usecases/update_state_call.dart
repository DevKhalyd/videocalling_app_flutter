import '../../../../core/utils/utils.dart';
import '../../data/api/videocall_firestore_repository.dart';

abstract class UpdateStateCall {
  /// Update the state of the call
  ///
  /// [callId] The id of the call
  ///
  /// [callState] The new state of the call
  static Future<void> execute(String callId, int newState) async {
    try {
      final repo = VideoCallFirestoreRepository();
      await repo.updateStateCall(callId, newState);
    } catch (e) {
      Utils.printACatch('UpdateStateCall', e);
    }
  }
}
