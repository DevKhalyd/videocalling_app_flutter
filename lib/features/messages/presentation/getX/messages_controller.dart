import 'package:get/get.dart';
import 'package:videocalling_app/core/utils/logger.dart';
import 'package:videocalling_app/core/utils/utils.dart';

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
    // TODO: Test for get the messages in the first launch`
    if (HomeController.to.user != null)
      _conversations = GetConversations.execute(HomeController.to.idUser);
    else
      Utils.runFunction(
        () {
          if (HomeController.to.user != null)
            _conversations = GetConversations.execute(HomeController.to.idUser);
          else
            Log.console('User is null so the id cannot be found');
        },
        milliseconds: 1000,
      );

    super.onInit();
  }
}
