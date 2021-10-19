import '../../../../core/shared/models/user/user.dart';
import '../../../../core/utils/utils.dart';
import '../../data/api/home_firestore_repository.dart';

abstract class UpdateFCMToken {
  /// [id] The id document in Firestore
  ///
  /// [token] The FCM token
  static Future<void> execute({
    required String id,
    required String token,
  }) async {
    try {
      final repo = HomeFirestoreRepository();
      await repo.updateUserData(id, User.tokenFCMField, token);
    } catch (e) {
      Utils.printACatch('UpdateUserOnlineStatus', e);
    }
  }
}
