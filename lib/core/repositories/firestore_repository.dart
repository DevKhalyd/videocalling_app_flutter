import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/calls/domain/models/history_call.dart';
import '../../features/calls/domain/usecases/create_history_item.dart';
import '../../features/home/domain/models/call_type.dart';
import '../../features/home/domain/models/conversation_type.dart';
import '../../features/sign_up/domain/usecases/add_user_data.dart';
import '../shared/models/user/user.dart';
import '../utils/data_test.dart';
import '../utils/logger.dart';
import '../utils/utils.dart';

/// Handle the main logic shared between the Firestore and each feature of the application.
abstract class FirestoreRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // NOTE: Collections in the database

  final String usernamesUnavaibles = 'usernames_unavaible';

  final String usersCollection = 'users';

  final String callsCollection = 'calls';

  // NOTE: Collections inside the user object or the main collection in firestore that contains the
  final String conversationsCollection = 'conversations';

  /// The collection inside of each user document
  final String historyCallsCollection = 'history_calls';

  final String messagesCollection = 'messages';

  // NOTE: Fields in the database

  final String usernameField = 'username';

  /// The ids in a conversation
  final String idsUser = 'idsUser';

  final String id = "id";

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

  /// Add data to a given collection
  ///
  /// [collection] The name collection to get the reference
  ///
  /// [data] The data to add to the collection
  ///
  /// [id] The id of the document to add the data
  Future<void> addDataWithOwnId(String collection, data, String id) async {
    try {
      await getCollection(collection).doc(id).set(data);
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

  /// Listen a given reference
  Stream<QuerySnapshot<Object?>> getStream(CollectionReference reference) {
    try {
      return reference.snapshots();
    } catch (e) {
      rethrow;
    }
  }
}

// Verify that the chat is created according to the backend logic...
const NOT_ID = "ID_NOT_INITIALIZED";

/// Use to emulate the firestore database
class EmulatorFirestoreRepository extends FirestoreRepository {
  EmulatorFirestoreRepository.init() {
    firestore.useFirestoreEmulator(Utils.localHost, 8080);
  }

  String idUserOne = NOT_ID;
  String idUserTwo = NOT_ID;

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
      username: DataTest.usernameOne,
      fullname: DataTest.fullnameOne,
      email: DataTest.emailOne,
      password: DataTest.password,
    );

    final testTwo = User(
      username: DataTest.usernameTwo,
      fullname: DataTest.fullnameTwo,
      email: DataTest.emailTwo,
      password: DataTest.password,
    );

    final userOne = await AddUserData.execute(user: testOne);

    if (userOne != null) {
      idUserOne = userOne.id;
    }

    final userTwo = await AddUserData.execute(user: testTwo);

    if (userTwo != null) {
      idUserTwo = userTwo.id;
    }

    if (userOne == null || userTwo == null) {
      log('Error adding users to firestore');
    } else {
      log('Users added...');
    }
  }

  Future<void> createHistoryItem() async {
    if (idUserOne == NOT_ID || idUserTwo == NOT_ID) {
      Log.console('$idUserOne $idUserTwo dont have id');
      return;
    }

    final historyForUserOne = HistoryCall(
      idUser: idUserTwo,
      callType: CallType(type: CallType.outcoming),
      conversationType: ConversationType(type: ConversationType.call),
      fullname: DataTest.fullnameTwo,
      username: DataTest.usernameTwo,
      date: 'Today',
    );

    final historyForUserTwo = HistoryCall(
      idUser: idUserOne,
      callType: CallType(type: CallType.incoming),
      conversationType: ConversationType(type: ConversationType.call),
      fullname: DataTest.fullnameOne,
      username: DataTest.usernameOne,
      date: 'Today',
    );

    await CreateHistoryItem.execute(idUserOne, historyForUserOne);

    await CreateHistoryItem.execute(idUserTwo, historyForUserTwo);
  }
}
