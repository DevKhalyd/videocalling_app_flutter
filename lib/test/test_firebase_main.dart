import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../core/repositories/fcm_repository.dart';
import '../core/shared/models/user/user.dart';
import '../core/utils/firebase_initalizer.dart';
import '../core/utils/logger.dart';
import '../core/widgets/mini_widgets.dart';
import '../features/home/domain/models/call.dart';
import '../features/sign_up/data/api/sign_up_fcm_repository.dart';
import '../features/sign_up/domain/usecases/add_user_data.dart';
import '../features/videcalll/domain/usecases/create_call.dart';

// TODO: Working in this way. Try to use the other method in the FCMRepository
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

/// This class basically helps to isolate and test each cloud function in the local environment. Then the cloud functions are uploaded to
/// the production environment.
void main() async {
  await FirebaseInitializer.execute();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(TestFirebaseMain());
}

class TestFirebaseMain extends StatefulWidget {
  @override
  State<TestFirebaseMain> createState() => _TestFirebaseMainState();
}

class _TestFirebaseMainState extends State<TestFirebaseMain> {
  @override
  void initState() {
    super.initState();
    FCMRepository.onMessage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Firebase Main',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Test Firebase'),
          ),
          body: Center(
            child: TextButton(
                onPressed: onPressed,
                child: TextCustom(
                  'Execute Action',
                  color: Colors.black,
                )),
          )),
    );
  }

  /// Execute each method to test it
  void onPressed() async {
    final repository = SignUpFCMRepository();
    final token = await repository.getToken();
    print(token);
    // Create the calls
    /*final ids = await createTwoUsers();
    createCall(ids);*/
  }

  Future<List<String>> createTwoUsers() async {
    Log.console('Testing the creation of users');
    final id = await createUserWithID('One');
    final id2 = await createUserWithID('Two');
    return [id!, id2!];
  }

  /// When a user wants to call another user
  void createCall([List<String>? ids]) async {
    Log.console('Testing the creation call...');
    var call = Call.test(date: Call.getDateNow());
    if (ids != null)
      call = Call.test(
        date: Call.getDateNow(),
        participantsIds: ids,
      );
    final response = await CreateCall.execute(call);
    Log.console('Response: $response.');
    Log.console('End test...');
  }

  Future<String?> createUserWithID(String name) async {
    final user = User.test(
      username: 'user_$name',
      fullname: name,
      tokenFCM: 'FCM TOKEN DEVICE',
    );

    final doc = await AddUserData.execute(user: user);

    if (doc != null) return doc.id;
  }

  // Test when a user has the data ready to be registered in the database
  addUserData() async {
    final user = User.test();
    final wasAddedData = await AddUserData.execute(user: user);
    Log.console('Was Added Data: $wasAddedData');
  }
}
