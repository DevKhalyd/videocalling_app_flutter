import 'package:cloud_firestore/cloud_firestore.dart';

/// Handle the main logic shared between the Firestore
abstract class FirestoreRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // NOTE: Collections in the database

  final String usernamesUnavaibles = 'usernames_unavaible';

  final String usersCollection = 'users';
  
  // NOTE: Fields in the database

  final String usernameField = 'userFirestoreRepositoryname';

  /// Add data to a given collection given
  Future<void> addData(
      CollectionReference collection, Map<String, dynamic> data) async {
    try {
      await collection.add(data);
    } catch (_) {
      rethrow;
    }
  }

  CollectionReference getCollection(String collection) =>
      firestore.collection(collection);
}

/// Use to emulate the firestore database
class EmulatorFirestoreRepository extends FirestoreRepository {
  EmulatorFirestoreRepository.init() {
    firestore.useFirestoreEmulator('localhost', 8080);
  }
}
