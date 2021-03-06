import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import '../repositories/auth_repository.dart';
import '../repositories/cloud_functions_repository.dart';
import '../repositories/firestore_repository.dart';

abstract class FirebaseInitializer {
  /// Isolate the initiazilation of the firebase and allow to test in a local environment.
  static Future<void> execute({
    bool testAuth = false,
    bool testFirestore = false,
    bool testFunctions = false,
  }) async {
    /// Ensure that the widgets are fine Initialized
    WidgetsFlutterBinding.ensureInitialized();

    /// Necessary to connect with the proper Firebase Project
    await Firebase.initializeApp();

    if (testAuth) {
      final auth = EmulatorAuthRepository();
      await auth.init();
      await auth.createAccounts();
    }

    if (testFirestore) {
      final firestore = EmulatorFirestoreRepository.init();
      await firestore.createAccountsData();
      await firestore.createHistoryItem();
    }
    if (testFunctions) EmulatorCloudFunctionsRepository.init();
  }
}
