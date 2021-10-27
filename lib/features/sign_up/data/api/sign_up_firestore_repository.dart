import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/repositories/firestore_repository.dart';
import '../../../../core/shared/models/user/user.dart';

/// Contains all the functions to use in the sign up fucntion
///
/// Then split into usecases
class SignUpFirestoreRepository extends FirestoreRepository {
  /// Return true if the username exits
  Future<bool> getUsername(String username) async {
    try {
      final querySnapshot = await getCollection(usernamesUnavaibles)
          .where(usernameField, isEqualTo: username.toLowerCase())
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }

  /// Add the user data
  Future<DocumentReference<Object?>> addUserData(User user) async {
    try {
      return await addData(usersCollection, user.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
