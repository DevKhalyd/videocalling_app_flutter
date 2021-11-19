import 'package:get/get.dart';
import '../widgets/dialogs/info_dialog.dart';

mixin FCMRepositoryMixin {
  Future<void> showDialogNotificationPermissionIOS() async {
    final content =
        "To work properly the application need that you guaranteed the notification permission. Otherwise, won't work as expected.";
    await Get.dialog(AlertInfo(content: content));
  }
}
