import '../../../../core/utils/utils.dart';
import '../../data/api/call_firestore_repository.dart';
import '../models/history_call.dart';

abstract class GetHistoryCalls {
  static Stream<List<HistoryCall>> execute(String idUser) async* {
    try {
      final repo = CallFirestoreRepository();

      await for (var snapshots in repo.getHistoryCalls(idUser)) {
        if (snapshots.docs.isEmpty) {
          yield [];
        } else {
          yield snapshots.docs
              .map(
                  (e) => HistoryCall.fromJson(e.data() as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (e) {
      Utils.printACatch('GetHistoryCalls', e);
      yield [];
    }
  }
}
