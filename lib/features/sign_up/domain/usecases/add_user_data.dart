import '../../../../core/shared/models/user/user.dart';
import '../../data/api/sign_up_firestore_repository.dart';

abstract class AddUserData {
  static Future<bool> execute({required User user}) async {
    try {
      final repo = SignUpFirestoreRepository();
      await repo.addUserData(user);
      return true;
    } catch (e) {
      return false;
    }
  }
}
