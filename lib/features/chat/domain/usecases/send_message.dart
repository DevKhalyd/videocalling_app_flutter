import '../../../../core/utils/utils.dart';
import '../../data/api/chat_firestore_repository.dart';
import '../models/message.dart';

abstract class SendMessage {
  static Future<void> execute(String idConversation, Message msg) async {
    try {
      final repo = ChatFirestoreRepository();
      await repo.sendMessage(idConversation, msg);
    } catch (e) {
      Utils.printACatch('SendMessage', e);
    }
  }
}
