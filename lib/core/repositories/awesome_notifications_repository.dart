import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

// Docs: https://pub.dev/packages/awesome_notifications

// Example: https://github.com/rafaelsetragni/awesome_notifications/tree/master/example

/// Handle the [AwesomeNotifications] logic and exposes the notifications most used.
class AwesomeNotificationsRepository {
  // Channels
  static const _videocallingChannel = '_videocallingChannel';

  // Keys
  static const keyHangUp = '_keyHangUp';
  static const keyAnswer = '_keyAnswer';

  /// If something is wrong is this initialization
  static final instance = AwesomeNotifications();

  /// Init the necessary methods for the notifications.
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
          channelName: 'Videocalling Channel',
          channelDescription:
              'Channel to use for the notifications of the videocalls.',
          defaultColor: Colors.blue,
          importance: NotificationImportance.Max,

          /// My own sound will be played
          playSound: false,

          /// Cannot be removed by the user
          locked: true,
        ),
      ],
      debug: true,
    );
  }

  /// Call this method in the screen most used.
  ///
  /// Request for the notification if needed.
  ///
  /// FCM also request for this permission so might be the permission
  /// is not needed because has access already.
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

  // TODO: Call this method to start to listen...

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
  static void listenNotifications({
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

  // TODO: Test the sounds when is called from the isolated and then try to stop from the app side...

  /// Show a incoming videocall and returs the [id] of this videocall.
  ///
  /// Useful to disappear the notification or updated
  ///
  /// [username] The username of the user who is calling.
  static int showVideocallNotification({required String username}) {
    final id = Utils.generateInteger();
    //https://pub.dev/packages/awesome_notifications#notificationcontent-content-in-push-data---required
    instance.createNotification(
        content: NotificationContent(
          id: id,
          channelKey: _videocallingChannel,
          title: username,
          body: 'Incoming videocall...',
          // TODO: Uncomment this one
          //displayOnForeground: false
        ),
        actionButtons: [
          NotificationActionButton(
            key: keyHangUp,
            label: 'Hang Up',
            buttonType: ActionButtonType.Default,
            isDangerousOption: true,
          ),
          NotificationActionButton(
            key: keyAnswer,
            label: 'Answer',
            color: Colors.green,
            buttonType: ActionButtonType.Default,
          ),
        ]);
    return id;
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
