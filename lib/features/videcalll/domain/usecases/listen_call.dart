import '../../../home/domain/models/call.dart';
import '../../data/api/videocall_repository.dart';

abstract class ListenCall {
  static Stream<Call?> execute(String callId) async* {
    try {
      final repo = VideoCallRepository();
      await for (var d in repo.listenCall(callId)) {
        final id = d.id;
        final data = d.data() as Map<String, dynamic>;
        final call = Call.fromJson(data);
        call.setId(id);
        yield call;
      }
    } catch (e) {
      yield null;
    }
  }
}
