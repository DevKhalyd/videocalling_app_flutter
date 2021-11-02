import 'package:firebase_core/firebase_core.dart';
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

  // TODO: Integrate this one: https://firebase.flutter.dev/docs/analytics/overview/#4-rebuild-your-app
  /// Listen to messages whilst your application is in the foreground
  static void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  // NOTE: Check if this one listen at terminated state
  /// Listen to messages whilst your application is in background.
  static void onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }
  // Docs:https://firebase.flutter.dev/docs/messaging/usage#handling-messages
}
