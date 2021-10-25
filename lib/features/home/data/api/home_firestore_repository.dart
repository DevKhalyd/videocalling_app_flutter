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
  ///
  /// [username] to search
  ///
  /// [thisUsername] The user who is looking for others usernames.
  /// In others words, the current user signed in this session.
  /// This allow to remove from the list given by firestore.
  Stream<List<User>> getUsersByUsername(
      String username, String thisUsername) async* {
    try {
      var usernameArray = username.split('');

      /// The query just acepts the first characters if this is not true then throw an Exception
      if (usernameArray.length > 10)
        usernameArray = usernameArray.getRange(0, 10).toList();

      /// Context: Firebase don't have a function that allow to search an user by sending the username or x param.
      /// Just search for a letter en specific. Example: If I give to firebase a letter called "A" then the query returns
      /// all the users that matches with that letter. So It's hard to search in firebase.
      ///
      /// Solution: When I create a new user a cloud function is triggered and split the username into an array. So this allow search a username
      /// by the parameter `arrayContainsAny` and make the following query.
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
          if (thisUsername != u.username) {
            u.clean();
            u.setId(d.id);
            users.add(u);
          }
        }
        yield users;
      }
    } catch (e) {
      rethrow;
    }
  }
}
