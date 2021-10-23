import 'package:flutter/material.dart';

import '../core/shared/models/user/user.dart';
import '../core/utils/firebase_initalizer.dart';
import '../core/utils/logger.dart';
import '../core/widgets/mini_widgets.dart';
import '../features/sign_up/domain/usecases/add_user_data.dart';

/// This class basically helps to isolate and test each cloud function in the local environment. Then the cloud functions are uploaded to
/// the production environment.
void main() async {
  await FirebaseInitializer.execute(testFirestore: true);
  runApp(TestFirebaseMain());
}

class TestFirebaseMain extends StatefulWidget {
  @override
  State<TestFirebaseMain> createState() => _TestFirebaseMainState();
}

class _TestFirebaseMainState extends State<TestFirebaseMain> {
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
    addUserData();
  }

  // Test when a user has the data ready.
  addUserData() async {
    final user = User.test();
    final wasAddedData = await AddUserData.execute(user: user);
    Log.console('Was Added Data: $wasAddedData');
  }
}
