
import '../../../../core/repositories/firestore_repository.dart';
import '../../../../core/shared/models/user/user.dart';

/// Contains all the functions to use in the sign up fucntion
///
/// Then split into usecases
class SignUpFirestoreRepository extends FirestoreRepository {
  /// Return true if the username exits
  Future<bool> getUsername(String username) async {
    try {
      final querySnapshot = await firestore
          .collection(usernamesUnavaibles)
          .where(usernameField)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }

  /// Add the user data
  Future<void> addUserData(User user) async {
    try {
      final collection = getCollection(usersCollection);
      await addData(collection, user.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
