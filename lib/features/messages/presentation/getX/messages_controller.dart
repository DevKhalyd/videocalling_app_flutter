import 'package:get/get.dart';

import '../../../../core/utils/logger.dart';
import '../../../../core/utils/utils.dart';
import '../../../home/presentation/getX/home_controller.dart';
import '../../domain/models/conversation.dart';
import '../../domain/usecases/get_conversations.dart';

/// All the conversations of this user.
class MessagesController extends GetxController {
  static MessagesController get to => Get.find();

  Stream<List<Conversation>>? _conversations;

  Stream<List<Conversation>>? get conversations => _conversations;

  @override
  void onInit() {
    if (HomeController.to.user != null)
      _conversations = GetConversations.execute(HomeController.to.idUser);
    else
      Utils.runFunction(
        () {
          if (HomeController.to.user == null) {
            Log.console('User is null so the id cannot be found');
            return;
          }
          _conversations = GetConversations.execute(HomeController.to.idUser);
          update();
        },

        /// Way for the user assigment
        milliseconds: 1500,
      );

    super.onInit();
  }
}
