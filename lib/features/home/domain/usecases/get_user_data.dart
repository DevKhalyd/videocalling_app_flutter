import '../../../../core/shared/models/user/user.dart';
import '../../../../core/utils/logger.dart';
import '../../data/api/home_firestore_repository.dart';

abstract class GetUserData {
  /// If return null the user must  be signOut
  ///
  /// [email] Email provided by Firestore
  static Future<User?> execute(String email) async {
    try {
      final repo = HomeFirestoreRepository();
      return repo.getUserData(email);
    } catch (e) {
      Log.console('GetUserData', L.E, e);
    }
  }
}
