import 'package:videocalling_app/core/utils/utils.dart';

import '../../../../core/shared/models/user/user.dart';
import '../../data/api/sign_up_firestore_repository.dart';

abstract class AddUserData {
  /// Add the user data to firestore.
  /// In other words, the basic info of this user is added in firestore.
  static Future<bool> execute({required User user}) async {
    try {
      final repo = SignUpFirestoreRepository();
      await repo.addUserData(user);
      return true;
    } catch (e) {
      Utils.printACatch('AddUserData', e);
      return false;
    }
  }
}
