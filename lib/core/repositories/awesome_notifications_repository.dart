import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
// Docs: https://pub.dev/packages/awesome_notifications

// Example: https://github.com/rafaelsetragni/awesome_notifications/tree/master/example

/// Handle the [AwesomeNotifications] logic and exposes the notifications most used.
class AwesomeNotificationsRepository {
  // consts

  /// The id of each notification
  static const idNotification = 'idNotification';

  // Channels
  static const _videocallingChannel = '_videocallingChannel';

  // Keys
  /// Hang up the call
  static const keyHangUp = '_keyHangUp';

  /// Answer the call
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

  /// Show a incoming videocall.
  ///
  /// [id] The id of the notification
  ///
  /// [username] The username of the user who is calling.
  ///
  /// [imageUrl] The image  of the user who is calling. According to the backend logic the image always comes not empty.
  ///
  /// [payload] The payload of the notification.
  static void showVideocallNotification({
    required int id,
    required String username,
    required String imageUrl,
    Map<String, String>? payload,
  }) {
    //https://pub.dev/packages/awesome_notifications#notificationcontent-content-in-push-data---required
    instance.createNotification(
        content: NotificationContent(
          id: id,
          channelKey: _videocallingChannel,
          title: username,
          body: 'Incoming videocall...',
          payload: payload,
          displayOnForeground: false,
          largeIcon: imageUrl,
        ),
        actionButtons: [
          NotificationActionButton(
            key: keyHangUp,
            label: 'Hang Up',
            // Remove the notification without open the application
            buttonType: ActionButtonType.KeepOnTop,
            isDangerousOption: true,
          ),
          NotificationActionButton(
            key: keyAnswer,
            label: 'Answer',
            color: Colors.green,
            buttonType: ActionButtonType.Default,
          ),
        ]);
  }

  static void testNotification() {
    instance.createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: _videocallingChannel,
          title: 'hello',
          body: 'Incoming videocall...',
          largeIcon:
              'https://lacollege.edu/wp-content/uploads/2021/09/blank-profile-picture.png',
        ),
        actionButtons: [
          NotificationActionButton(
            key: keyHangUp,
            label: 'Hang Up',
            // Remove the notification without open the application
            buttonType: ActionButtonType.KeepOnTop,
            isDangerousOption: true,
          ),
          NotificationActionButton(
            key: keyAnswer,
            label: 'Answer',
            color: Colors.green,
            buttonType: ActionButtonType.Default,
          ),
        ]);
  }

  /// Remove a notification give it's [id]
  static deleteNotification(int id) => instance.cancel(id);

  static bool isVideocallChannel(String? key) => key == _videocallingChannel;
}

/*
Methods to use in the future...
To use:  NotificationActionButton(
            key: 'button3',
            label: 'InputField',
            buttonType: ActionButtonType.InputField,
          ),
 */
