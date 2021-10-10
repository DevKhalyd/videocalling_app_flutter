import '../../../../core/repositories/firestore_repository.dart';
import '../../../../core/shared/models/user/user.dart';
import '../../../../core/utils/logger.dart';

class HomeFirestoreRepository extends FirestoreRepository {
  /// [id] The id of the document
  ///
  /// [field] The field to update
  ///
  /// [value] The value of the field. Must be non-null
  Future<void> updateUserData(String id, String field, dynamic value) async {
    assert(value != null);
    try {
      await getCollection(usersCollection).doc(id).update({field: value});
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getUserData(String email) async {
    try {
      final query = await getCollection(usersCollection)
          .where(User.emailField, isEqualTo: email)
          .get();

      if (query.docs.isEmpty) throw ('Docs not found');
      final doc = query.docs[0];
      final user = User.fromJson(doc.data() as Map<String, dynamic>);
      Log.console('Password: ${user.password}');
      user.clean();
      user.setId(doc.id);
      Log.console('New Password: ${user.password}');
      return user;
    } catch (e) {
      rethrow;
    }
  }
}
