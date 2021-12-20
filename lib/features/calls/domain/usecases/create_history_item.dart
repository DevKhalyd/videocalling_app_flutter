import '../../../../core/utils/utils.dart';
import '../../data/api/call_firestore_repository.dart';
import '../models/history_call.dart';

abstract class CreateHistoryItem {
  static Future<void> execute(String id, HistoryCall h) async {
    try {
      final repo = CallFirestoreRepository();
      await repo.createHistoryItem(id, h);
    } catch (e) {
      Utils.printACatch('CreateHistoryItem', e);
    }
  }
}
