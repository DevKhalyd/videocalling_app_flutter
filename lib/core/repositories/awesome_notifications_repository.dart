import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

// Docs: https://pub.dev/packages/awesome_notifications

// Example: https://github.com/rafaelsetragni/awesome_notifications/tree/master/example

/// Handle the [AwesomeNotifications] logic and exposes the notifications most used.
class AwesomeNotificationsRepository {
  static const _videocallingChannel = '_videocallingChannel';

  /// If something is wrong is this initialization
  static final instance = AwesomeNotifications();

  /// Init the necessary methods
  ///
  /// Call in the main method of the app
  AwesomeNotificationsRepository.init() {
    instance.initialize(
      // Media source: https://pub.dev/packages/awesome_notifications#media-source-types
      // set the icon to null if you want to use the default app icon
      null,
      // 'resource://drawable/res_app_icon',
      <NotificationChannel>[
        // Notification Channels documentation
        // https://pub.dev/packages/awesome_notifications#notification-channels
        NotificationChannel(
          channelKey: _videocallingChannel,
          channelName: 'VideocallingChannel',
          channelDescription:
              'Channel to use for the notifications of the videocalls.',
          defaultColor: Colors.blue,
          importance: NotificationImportance.Max,

          /// My own sound will be played
          /// ERROR: When the Native code tries to read [playSound]
          /// throws a NullPointerException
          playSound: false,

          /// Cannot be removed by the user
          locked: true,
        ),
      ],
      debug: true,
    );

    // TODO: Listen in other place
    _listenNotifications();
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

  /// Listen according to each function passed.
  ///
  /// Listen after the initialization
  ///
  /// Docs: https://pub.dev/packages/awesome_notifications#flutter-streams
  ///
  /// [onAction] Capture all actions (tap) over notifications
  ///
  /// [onCreated] Capture all created notifications
  ///
  /// [onDisplayed] Capture all notifications displayed on user's screen.
  ///
  /// [onDismessed] Capture all notifications dismissed by the user.
  void _listenNotifications({
    Function(ReceivedAction)? onAction,
    Function(ReceivedNotification)? onCreated,
    Function(ReceivedNotification)? onDisplayed,
    Function(ReceivedNotification)? onDismessed,
  }) {
    if (onCreated != null) instance.createdStream.listen(onCreated);
    if (onAction != null) instance.actionStream.listen(onAction);
    if (onDisplayed != null) instance.displayedStream.listen(onDisplayed);
    if (onDismessed != null) instance.dismissedStream.listen(onDismessed);
  }

  static void testNotification() {
    // Read: https://pub.dev/packages/awesome_notifications#notification-channels
    instance.createNotification(
        content: NotificationContent(
      id: 1,
      channelKey: _videocallingChannel,
      title: 'Hello There',
      body: 'Wasup',
      locked: true,
      autoDismissable: false,
    ));
  }

  static void buttonNotification() {
    //https://pub.dev/packages/awesome_notifications#notificationcontent-content-in-push-data---required
    instance.createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: _videocallingChannel,
          title: 'Hello There Video',
          body: 'Wasup',
          //displayOnForeground: false
        ),
        schedule: NotificationCalendar(repeats: true),
        actionButtons: [
          NotificationActionButton(
            key: '1',
            label: 'Hang Up',
            buttonType: ActionButtonType.Default,
            isDangerousOption: true,
          ),
          NotificationActionButton(
            key: '2',
            label: 'Answer',
            color: Colors.green,
            buttonType: ActionButtonType.Default,
          ),
        ]);
  }
}

/*
Methods to use in the future...
To use:  NotificationActionButton(
            key: 'button3',
            label: 'InputField',
            buttonType: ActionButtonType.InputField,
          ),
 */
