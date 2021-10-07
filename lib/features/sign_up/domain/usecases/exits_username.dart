import '../../../../core/logger.dart';
import '../../data/api/sign_up_firestore_repository.dart';

abstract class ExistsUsername {
  /// If return null means that something went wrong.
  ///
  /// `true` Exists the username.
  ///
  /// `false` Does not exists the username.
  static Future<bool?> execute({required String username}) async {
    final repo = SignUpFirestoreRepository();
    try {
      return await repo.getUsername(username);
    } catch (e) {
      Log.console('ExistsUsername', L.E, e);
      return null;
    }
  }
}
