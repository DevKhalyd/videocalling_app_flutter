import '../../../../core/utils/utils.dart';
import '../../../home/domain/models/call.dart';
import '../../data/api/videocall_firestore_repository.dart';

abstract class ListenCall {
  /// Listen a given call
  static Stream<Call?> execute(String callId) async* {
    try {
      final repo = VideoCallFirestoreRepository();
      await for (var d in repo.listenCall(callId)) {
        final id = d.id;
        final data = d.data() as Map<String, dynamic>;
        final call = Call.fromJson(data);
        call.setId(id);
        yield call;
      }
    } catch (e) {
      Utils.printACatch('ListenCall', e);
      yield null;
    }
  }
}
