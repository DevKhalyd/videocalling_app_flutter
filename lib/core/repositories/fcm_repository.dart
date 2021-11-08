import 'dart:developer';
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../bridges/fcm_bridge.dart';
import '../enums/fcm_enums.dart';
import '../utils/fcm_keys.dart';
import '../utils/logger.dart';
import '../utils/routes.dart';

// Docs: https://firebase.flutter.dev/docs/messaging/usage#requesting-permission-apple--web

abstract class FCMRepository {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // NOTE: Check this option to open a specific screen
  //messaging.getInitialMessage();

  Future<String?> getToken() async {
    if (Platform.isAndroid) return await messaging.getToken();

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      // Messages or videocalling notification
      //criticalAlert: false,
      //provisional: false,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional)
      return await messaging.getToken();
  }

  /// Listen to messages whilst your application is in the foreground
  static void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final data = message.data;

      if (notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }

      if (data.isEmpty) {
        Log.console(
            'Because the logic of the application the data should not be empty',
            L.E);
        return;
      }

      if (data.containsKey(FCMKeys.idVideocall)) {
        final idVideocall = data[FCMKeys.idVideocall];
        if (idVideocall.isEmpty) {
          Log.console('The idVideocall should be not empty', L.E);
          return;
        }

        /// Context: Basically the caller sends the notification to the receiver
        ///
        /// Then if this one is avaible and the application is running in the foreground
        ///
        /// Then the application will open the videocall screen. Without questions to answer the call
        /// because that is the logic that I want to implement.
        ///
        /// If the application is not running in the foreground (Background or Terminated), then the application will ask for answer the call.

        final arguments = FCMBridge(
          type: TypeContent.videocall,
          value: idVideocall,
        );

        Get.toNamed(
          Routes.videocall,
          arguments: arguments,
        );
      }
    });
  }

  // NOTE: Check if this one listen at terminated state
  /// Listen to messages whilst your application is in background or terminated.
  static void onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Docs:https://firebase.flutter.dev/docs/messaging/usage#handling-messages
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
