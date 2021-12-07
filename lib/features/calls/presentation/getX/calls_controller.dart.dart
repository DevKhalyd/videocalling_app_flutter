import 'package:get/get.dart';
import 'package:videocalling_app/core/widgets/dialogs/waiting_dialog.dart';
import 'package:videocalling_app/features/calls/domain/usecases/create_conversation.dart';
import 'package:videocalling_app/features/calls/domain/usecases/get_id_conversation.dart';
import 'package:videocalling_app/features/chat/domain/models/chat_bridge.dart';

import '../../../../core/shared/models/user/user.dart';
import '../../../home/presentation/getX/home_controller.dart';
import '../../../messages/presentation/getX/messages_controller.dart';
import '../../domain/models/history_call.dart';
import '../../domain/usecases/get_history_calls.dart';

class CallsController extends GetxController {
  final idUser = HomeController.to.user?.id;
  Stream<List<HistoryCall>> get historyCalls =>
      GetHistoryCalls.execute(idUser!);

  /// Go to the chat page from the history call page
  void onChat(HistoryCall h) async {
    /// When opens a chat screen send a user object to show in the screen
    /// then listen to the changes from firestore...

    final user = User(
      username: h.username,
      fullname: h.fullname,
      imageUrl: h.imgUrl,
    );
    user.setId(h.idUser);

    /// Wait for some actions
    Get.dialog(WaitingDialog());

    /// current id user - id user to talk with
    final ids = <String>[HomeController.to.idUser, h.idUser];

    String? idConversation = await GetIdConversation.execute(ids);

    if (idConversation == null)
      // Create the conversation
      idConversation = await CreateConversation.execute(ids);

    /// Go to the chat page
    final c = ChatBridge(idConversation: idConversation, user: user);
    MessagesController.to.onOpenChat(c);
  }
}
