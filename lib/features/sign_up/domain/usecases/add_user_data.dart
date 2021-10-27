import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/shared/models/user/user.dart';
import '../../../../core/utils/utils.dart';
import '../../data/api/sign_up_firestore_repository.dart';

abstract class AddUserData {
  /// Add the user data to firestore.
  /// In other words, the basic info of this user is added in firestore.
  static Future<DocumentReference<Object?>?> execute(
      {required User user}) async {
    try {
      final repo = SignUpFirestoreRepository();
      return await repo.addUserData(user);
    } catch (e) {
      Utils.printACatch('AddUserData', e);
    }
  }
}
