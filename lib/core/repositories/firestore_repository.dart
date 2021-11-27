import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/sign_up/domain/usecases/add_user_data.dart';
import '../shared/models/user/user.dart';
import '../utils/logger.dart';
import '../utils/utils.dart';

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

  /// Get a document from a collection
  DocumentReference getDocumentReference(String collection, String document) =>
      getCollection(collection).doc(document);

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
    firestore.useFirestoreEmulator(Utils.localHost, 8080);
  }

  /// Add the data to firestore emulator as mock.
  Future<void> createAccountsData() async {
    final qs = await getCollection(usersCollection)
        .where(User.emailField, isEqualTo: 't1@gmail.com')
        .get();

    if (qs.docs.isNotEmpty) {
      log('Data added already in firestore');
      return;
    }

    /// In this case, the FCM is not requested because the application
    /// has not context a this point
    // tokenFCM:

    final testOne = User(
      username: 'testOne',
      fullname: 'Test One',
      email: 't1@gmail.com',
      password: '123456',
    );

    final testTwo = User(
      username: 'testTwo',
      fullname: 'Test Two',
      email: 't2@gmail.com',
      password: '123456',
    );

    AddUserData.execute(user: testOne).then((value) {
      if (value == null) {
        Log.console('Something went wrong just happens');
        return;
      }
      log('Test one added');
    });
    AddUserData.execute(user: testTwo).then((value) {
      if (value == null) {
        Log.console('Something went wrong just happens');
        return;
      }
      log('Test two added');
    });
  }
}
