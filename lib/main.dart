import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/repositories/awesome_notifications_repository.dart';
import 'core/repositories/fcm_repository.dart';
import 'core/utils/firebase_initalizer.dart';
import 'core/utils/routes.dart';
import 'core/utils/utils.dart';
import 'features/videcalll/presentation/mixin/videocall_utils.dart';

void main() async {
  await FirebaseInitializer.execute();
  FCMRepository.onBackgroundMessage();
  AwesomeNotificationsRepository.init();
  runApp(VideocallingApp());
}

class VideocallingApp extends StatelessWidget with VideoCallMixin {
  @override
  Widget build(BuildContext context) {
    AwesomeNotificationsRepository.listenNotifications(
      onAction: (notification) {
        // TODO: Do some validations when the user press the a button
        // 1. Update the database with the new state of the call
        // 2. Work with the button that was pressed
        // 3. Update the UI if the answer button was pressed
        //(Send the FCMBridge to the videocall screen to works properly)

        if (AwesomeNotificationsRepository.isVideocallChannel(
          notification.channelKey,
        )) {
          // If both come empty means that the user touch the notification. So answer the notification.
          onVideoCallingKeyPressed(
            notification.buttonKeyPressed,
            payload: notification.payload,
          );
        }
      },
    );
    return GetMaterialApp(
      theme: ThemeData(iconTheme: IconThemeData(color: Colors.white)),
      title: Utils.appName,
      initialRoute: Routes.initial,
      getPages: Routes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
