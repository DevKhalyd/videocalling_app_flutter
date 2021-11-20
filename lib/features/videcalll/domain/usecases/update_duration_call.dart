import 'package:videocalling_app/core/utils/utils.dart';
import 'package:videocalling_app/features/videcalll/data/api/videocall_firestore_repository.dart';

abstract class UpdateDurationCall {
  static Future<void> execute(String callId, String duration) async {
    try {
      final repo = VideoCallFirestoreRepository();
      await repo.updateDurationCall(callId, duration);
    } catch (e) {
      Utils.printACatch('UpdateDurationCall', e);
    }
  }
}
