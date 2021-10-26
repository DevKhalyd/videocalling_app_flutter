import 'package:cloud_firestore/cloud_firestore.dart';

/// Handle the main logic shared between the Firestore and each feature of the application.
abstract class FirestoreRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // NOTE: Collections in the database

  final String usernamesUnavaibles = 'usernames_unavaible';

  final String usersCollection = 'users';

  final String callsCollection = 'calls';

  // NOTE: Fields in the database

  final String usernameField = 'username';

  /// Useful to write only the collection name
  CollectionReference getCollection(String collection) =>
      firestore.collection(collection);

  /// Add data to a given collection
  ///
  /// [collection] The name collection to get the reference
  ///
  /// [data] The data to add to the collection
  Future<DocumentReference<Object?>> addData(
      String collection, Map<String, dynamic> data) async {
    try {
      return await getCollection(collection).add(data);
    } catch (_) {
      rethrow;
    }
  }

  /// [collection] to update.
  /// [documentID] The id of the document to update.
  /// [field] The field in that document to update.
  /// [data] The data to update. Basically a JSON object.
  Future<void> updateData({
    required String collection,
    required String documentID,
    required String field,
    required dynamic data,
  }) async {
    try {
      await getCollection(collection).doc(documentID).update({field: data});
    } catch (_) {
      rethrow;
    }
  }

  /// Listen a given collection
  Stream<QuerySnapshot> listenCollection(String collection) {
    try {
      return getCollection(collection).snapshots();
    } catch (_) {
      rethrow;
    }
  }

  /// Listen a given document
  Stream<DocumentSnapshot> listenDocument(
      String collection, String idDocument) {
    try {
      return getCollection(collection).doc(idDocument).snapshots();
    } catch (_) {
      rethrow;
    }
  }
}

/// Use to emulate the firestore database
class EmulatorFirestoreRepository extends FirestoreRepository {
  EmulatorFirestoreRepository.init() {
    firestore.useFirestoreEmulator('localhost', 8080);
  }
}
