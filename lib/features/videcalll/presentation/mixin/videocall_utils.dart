import 'dart:developer';

import 'package:get/get.dart';

import '../../../../core/bridges/fcm_bridge.dart';
import '../../../../core/enums/fcm_enums.dart';
import '../../../../core/repositories/awesome_notifications_repository.dart';
import '../../../../core/utils/fcm_keys.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/routes.dart';
import '../../../home/domain/models/call_state.dart';
import '../../domain/usecases/update_state_call.dart';

mixin VideoCallMixin {
  /// Milliseconds to wait for the answer of the user
  final maxDurationToWait = 40000;

  /// Given [seconds] return the minutes and seconds in the following format
  /// 00:00
  String getMinutesFromSeconds(int seconds) {
    int minutes = seconds ~/ 60;
    int secondsInt = seconds % 60;
    String secondsString = secondsInt.toString();
    if (secondsInt < 10) secondsString = '0$secondsInt';
    return '$minutes:$secondsString';
  }

  /// When a button notification is pressed is representated by a [key]
  ///
  /// This method is used in the [main] method of the application.
  ///
  /// Basically do an action according to the response from the user.
  ///
  /// [payload] The data received from the notification.
  ///
  /// This method is important for the videocalling notifications
  void onVideoCallingKeyPressed(
    String key, {
    Map<String, String>? payload,
  }) {
    // At this point Firebase is already initialized
    if (payload == null) {
      final msg =
          '''Because the logic of the application the payload cannot be null.
          Check out when the notification is created.''';
      Log.console(msg, L.E);
      return;
    }

    final idNotification =
        payload[AwesomeNotificationsRepository.idNotification];
    final idVideocall = payload[FCMKeys.idVideocall];
    final username = payload[FCMKeys.username];

    if (idNotification == null || idVideocall == null || username == null) {
      Log.console('''Some values comes null. 
          Please check out: $idNotification - $idVideocall - $username''', L.E);
      return;
    }

    /// Because if the key comes empty means that the user tap the notification
    if (key == AwesomeNotificationsRepository.keyAnswer || key.isEmpty) {
      //  Update the database with the new state of the call
      UpdateStateCall.execute(idVideocall, CallState.stateOnCall);
      // note: Here I could do other validations like if the user is signed in.
      // Since my goal with this project is to understand how works the cloud functions, agora and  the notifications
      // this is not necessary by this moment. Maybe in the future I'll do it.
      Get.offAndToNamed(
        Routes.videocall,
        arguments: FCMBridge(type: TypeContent.videocall, value: idVideocall),
      );
      return;
    }

    if (key == AwesomeNotificationsRepository.keyHangUp) {
      log('Updating videocalling for hang up action');
      // Update the database with finalized
      UpdateStateCall.execute(idVideocall, CallState.stateLost);
      return;
    }
    Log.console('The key contains a invalid value: ' + key, L.W);
  }
}
