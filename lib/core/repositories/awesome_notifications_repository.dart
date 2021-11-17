import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

// Docs: https://pub.dev/packages/awesome_notifications

//Example: https://github.com/rafaelsetragni/awesome_notifications/tree/master/example

/// Handle the [AwesomeNotifications] logic and exposes the notifications most used.
class AwesomeNotificationsRepository {
  static const keyBasicChannel = "basicChannel";

  /// If something is wrong is this initialization
  static final instance = AwesomeNotifications();

  /// Init the necessary methods
  ///
  /// Call in the main method of the app
  AwesomeNotificationsRepository.init() {
    instance.initialize(
      // set the icon to null if you want to use the default app icon
      null,
      // 'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: keyBasicChannel,
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Colors.red,
          ledColor: Colors.white,
        )
      ],
      debug: true,
    );
  }

  /// Call this method in the screen most used.
  ///
  /// Request for the notification if needed
  static void requestNotificationPermission() {
    instance.isNotificationAllowed().then((isAllowed) {
      log('isAllowed Notifications: $isAllowed');
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        instance.requestPermissionToSendNotifications();
      }
    });
  }

  /// Listen when a notification is tapped
  ///
  /// Listen after the initialization
  listenToNotifications(Function(ReceivedAction) onListen) {
    instance.actionStream.listen(onListen);
  }

  // TODO: Create a notification method when everything is working.

  testNotification() {
    instance.createNotification(
        content: NotificationContent(
      id: 10,
      channelKey: keyBasicChannel,
      title: 'Simple Notification',
      body: 'Simple body',
    ));
  }
}
