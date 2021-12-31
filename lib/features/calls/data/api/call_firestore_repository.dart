import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/repositories/firestore_repository.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/models/history_call.dart';

class CallFirestoreRepository extends FirestoreRepository {
  /// Return the history of calls of this user
  Stream<QuerySnapshot<Object?>> getHistoryCalls(String idDoc) {
    try {
      final historyCalls = '$usersCollection/$idDoc/$historyCallsCollection';
      return getCollection(historyCalls).snapshots();
    } catch (e) {
      rethrow;
    }
  }

  /// Create a history item just for test.
  Future<void> createHistoryItem(String idUser, HistoryCall historyCall) async {
    try {
      final collection =
          getCollection('$usersCollection/$idUser/$historyCallsCollection');
      await collection.add(historyCall.toJson());
    } catch (e) {
      rethrow;
    }
  }

  /// [ids] is a list of ids of users.
  ///
  /// Return the id of the conversation created.
  Future<String> createConversation(List<String> ids) async {
    assert(ids.length == 2, 'A conversation must have two users');
    try {
      final conversationId = Utils.generateId(Utils.conversationSuffix);

      final data = <String, dynamic>{
        // id
        id: conversationId,
        // ids
        idsUser: ids,
      };
      await addDataWithOwnId(conversationsCollection, data, conversationId);
      return conversationId;
    } catch (e) {
      rethrow;
    }
  }

  /// Return the id of the conversation of two users if exits
  ///
  /// [ids] List of ids of the users
  ///
  /// If returns null means that the conversation doesn't exist. So create one.
  ///
  /// The above method create a conversation if it doesn't exist.
  Future<String?> getIdConversation(List<String> ids) async {
    assert(ids.length == 2, 'A conversation must have two users');
    try {
      // Search for those ids
      final query = await getCollection(conversationsCollection)
          .where(idsUser, arrayContainsAny: ids)
          .get();

      final docs = query.docs;

      if (docs.isEmpty) return null;

      String? idConversation;

      for (final d in docs) {
        final data = d.data() as Map<String, dynamic>;

        if (data.containsKey(idsUser)) {
          final idsUserData = data[idsUser] as List<dynamic>;
          if (idsUserData.length != 2) {
            Log.console('Don\'t have two users. Check this object $data');
            continue;
          }

          if (ids.contains(idsUserData[0]) && ids.contains(idsUserData[1])) {
            if (!data.containsKey(id)) {
              Log.console('Don\'t have id. Check this document $data', L.W);
              continue;
            }
            idConversation = data[id] as String;
            break;
          }
        }
      }

      return idConversation;
    } catch (e) {
      rethrow;
    }
  }
}
