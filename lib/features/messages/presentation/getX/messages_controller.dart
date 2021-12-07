import 'package:get/get.dart';

import '../../../../core/utils/routes.dart';
import '../../../chat/domain/models/chat_bridge.dart';
import '../../../home/presentation/getX/home_controller.dart';
import '../../domain/models/conversation.dart';
import '../../domain/usecases/get_conversations.dart';

/// All the conversations of this user.
class MessagesController extends GetxController {
  static MessagesController get to => Get.find();

  Stream<List<Conversation>> get getConversations =>
      GetConversations.execute(HomeController.to.idUser);

  /// Go to the chat screen and configure all the data needed
  /// to start / continue the conversation.
  void onOpenChat(ChatBridge c) => Get.toNamed(Routes.chat, arguments: c);
}
