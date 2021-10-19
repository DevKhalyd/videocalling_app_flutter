import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' show Platform;

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
}
