import 'package:videocalling_app/core/shared/models/user/user.dart';

import '../../../../core/utils/utils.dart';
import '../../data/api/home_firestore_repository.dart';

abstract class UpdateUserOnlineStatus {
  static Future<void> execute({
    required String id,
    required bool isOnline,
  }) async {
    try {
      final repo = HomeFirestoreRepository();
      await repo.updateUserData(id, User.isOnlineField, isOnline);
    } catch (e) {
      Utils.printACatch('UpdateUserOnlineStatus', e);
    }
  }
}
