// Add the camera and microphone permission
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:videocalling_app/core/widgets/dialogs/info_dialog.dart';

mixin PermissionHandlerMixin {
  /// The main method that asks for the permissions necessary to start a videocall
  Future<void> askForCameraAndMicroPhonePermission() async {
    final permissionsToAsk = <Permission>[];

    final cameraStatus = await Permission.camera.status;

    if (cameraStatus.isDenied || cameraStatus.isLimited)
      permissionsToAsk.add(Permission.camera);

    final microphoneStatus = await Permission.microphone.status;

    if (microphoneStatus.isDenied || microphoneStatus.isLimited)
      permissionsToAsk.add(Permission.microphone);

    if (permissionsToAsk.isEmpty) return;

    final msg =
        'We are gonna to ask you for the permissions necessary to start a video call. Please, accept the permissions.';

    await Get.dialog(AlertInfo(content: msg));

    final statuses = await permissionsToAsk.request();

    bool showDeniedPermissionsMsg = false;

    statuses.forEach((_, val) {
      if (val.isDenied || val.isPermanentlyDenied)
        showDeniedPermissionsMsg = true;
    });

    if (!showDeniedPermissionsMsg) return;

    await Get.dialog(AlertInfo(
        content:
            'You have denied some permissions. Please, go to the settings and accept the permissions.'));
    openAppSettings();
  }
}
