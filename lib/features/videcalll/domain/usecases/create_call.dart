import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:videocalling_app/core/utils/utils.dart';
import 'package:videocalling_app/features/videcalll/data/api/videocall_firestore_repository.dart';
import '../../../home/domain/models/call.dart';

abstract class CreateCall {
  static Future<DocumentReference?> execute(Call call) async {
    try {
      final repo = VideoCallFirestoreRepository();
      return await repo.createCall(call);
    } catch (e) {
      Utils.printACatch('CreateCall', e);
      return null;
    }
  }
}
