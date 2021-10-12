import '../../../../core/repositories/firestore_repository.dart';
import '../../../../core/shared/models/user/user.dart';

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

  /// Get the user data from firebase
  Future<User> getUserData(String email) async {
    try {
      final query = await getCollection(usersCollection)
          .where(User.emailField, isEqualTo: email)
          .get();

      if (query.docs.isEmpty) throw ('Docs not found');
      final doc = query.docs[0];
      final user = User.fromJson(doc.data() as Map<String, dynamic>);
      user.clean();
      user.setId(doc.id);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// Get a list of users given a username
  Stream<List<User>> getUsersByUsername(String username) async* {
    try {
      var usernameArray = username.split('');

      if (usernameArray.length > 10)
        usernameArray = usernameArray.getRange(0, 10).toList();

      final query = getCollection(usersCollection)
          .where(User.userNameQueryField, arrayContainsAny: usernameArray)
          .snapshots();

      await for (final q in query) {
        final docs = q.docs;

        if (docs.isEmpty) {
          yield [];
          return;
        }

        final users = <User>[];

        for (final d in docs) {
          final data = d.data() as Map<String, dynamic>;
          final u = User.fromJson(data);
          u.clean();
          users.add(u);
        }
        yield users;
      }
    } catch (e) {
      rethrow;
    }
  }
}
