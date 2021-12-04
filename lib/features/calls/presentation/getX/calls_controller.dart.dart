import 'package:get/get.dart';

import '../../../../core/shared/models/user/user.dart';
import '../../../home/presentation/getX/home_controller.dart';
import '../../../messages/presentation/getX/messages_controller.dart';
import '../../domain/models/history_call.dart';
import '../../domain/usecases/get_history_calls.dart';

class CallsController extends GetxController {
  final idUser = HomeController.to.user?.id;
  Stream<List<HistoryCall>> get historyCalls =>
      GetHistoryCalls.execute(idUser!);

  /// Go to the chat page.
  void onChat(HistoryCall h) async {
    /// When opens a chat screen send a user object to show in the screen
    /// then listen to the changes from firestore...

    final user = User(
      username: h.username,
      fullname: h.fullname,
      imageUrl: h.imgUrl,
    );

    MessagesController.to.onOpenChat(user);
  }
}
