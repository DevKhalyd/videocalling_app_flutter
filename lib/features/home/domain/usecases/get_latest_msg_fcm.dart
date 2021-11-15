import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../core/utils/utils.dart';
import '../../data/api/home_fcm_repository.dart';

abstract class GetLatestMessageFCM {
  /// Use to open the video screen if that notification is received
  static Future<RemoteMessage?> execute() async {
    try {
      final repo = HomeFCMRepository();
      return await repo.getLastMessageFromFCM();
    } catch (e) {
      Utils.printACatch('GetLatestMessageFCM', e);
    }
  }
}
