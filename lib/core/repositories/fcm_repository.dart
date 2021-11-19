import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';

import '../../features/home/domain/models/call.dart';
import '../../features/home/domain/models/call_state.dart';
import '../../features/videcalll/domain/usecases/listen_call.dart';
import '../bridges/fcm_bridge.dart';
import '../enums/fcm_enums.dart';
import '../utils/fcm_keys.dart';
import '../utils/logger.dart';
import '../utils/routes.dart';
import '../utils/utils.dart';
import 'awesome_notifications_repository.dart';

// Docs: https://firebase.flutter.dev/docs/messaging/usage#requesting-permission-apple--web
abstract class FCMRepository {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// Use if you want to get the latest message sent to the application.
  ///
  /// Serves to open a screen or manipulate the logic.
  Future<RemoteMessage?> getLastMessageFromFCM() {
    return messaging.getInitialMessage();
  }

  Future<String?> getToken() async {
    if (Platform.isAndroid) return await messaging.getToken();

    // IMPROVE: Before to ask for the permission. Show a dialog the reason of that dialog.
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
      handleRemoteMessage(message);
    });
  }

  /// Listen to messages whilst your application is in background or terminated.
  static void onBackgroundMessage() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Docs:https://firebase.flutter.dev/docs/messaging/usage#handling-messages
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Docs: https://firebase.flutter.dev/docs/messaging/usage#background-messages

  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  /*
  Since the handler runs in its own isolate outside your applications context, 
  it is not possible to update application state or execute any UI impacting logic. 
  You can however perform logic such as HTTP requests, 
  IO operations (updating local storage), communicate with other plugins etc.

  It is also recommended to complete your logic as soon as possible. 
  Running long intensive tasks impacts device performance and may cause 
  the OS to terminate the process. If tasks run for longer than 30 seconds,
  the device may automatically kill the process.
  */

  // TODO: Update the type of the notification in the functions... (Isolate)
  //(No title and body (Silent)). Send a silent notification from FCM functions
  // FlutterRingtonePlayer.stop();

  final data = message.data;

  // Create the notification to display
  if (data.containsKey(FCMKeys.idVideocall)) {
    // TODO: Send the name of the user who is calling (Cloud functions)
    final username = '\$UserName';
    final idVideocall = data[FCMKeys.idVideocall];
    if (idVideocall.isEmpty || username.isEmpty) {
      Log.console('The idVideocall should be not empty', L.E);
      return;
    }

    final stream = ListenCall.execute(idVideocall);

    /// Call object from the stream
    Call? c;

    final subscription = stream.listen((call) {
      if (call == null) {
        Log.console('The call is comming null', L.E);
        return;
      }
      c = call;

      final state = call.callState;

      if (state.shouldStopRingtone()) FlutterRingtonePlayer.stop();
    });

    /// After of 30s the subscription is closed.
    Utils.runFunction(() {
      subscription.cancel();
      final state = c?.callState;
      if (state == null) {
        Log.console(
            'After the subscription is closed. Tried to make some validations but was not able to make',
            L.E);
        return;
      }
      if (state.shouldStopRingtone() || state.type == CallState.stateCalling)
        FlutterRingtonePlayer.stop();
    }, milliseconds: 30000);
    // Create the notification and start the ringtone sound
    final id = Utils.generateInteger();
    FlutterRingtonePlayer.playRingtone();
    AwesomeNotificationsRepository.showVideocallNotification(
        id: id,
        username: username,
        payload: {
          // Helps to cancel the notification or update it
          AwesomeNotificationsRepository.idNotification: id.toString(),
          FCMKeys.idVideocall: idVideocall,
          FCMKeys.userName: username,
        });
  }
}

/// This method helps to handle the messages from the FCM.
///
/// [message] The current message sent by FCM.
///
/// Use when you have a context to use in the application. Otherwise, will fail the application.
Future<void> handleRemoteMessage(RemoteMessage message) async {
  final data = message.data;

  if (data.containsKey(FCMKeys.idVideocall)) {
    final idVideocall = data[FCMKeys.idVideocall];

    /// An error from the cloud functions...
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
}
