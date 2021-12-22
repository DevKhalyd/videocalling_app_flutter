import 'package:firebase_auth/firebase_auth.dart';

import '../../features/sign_up/domain/usecases/sign_up_with_email.dart';
import '../utils/data_test.dart';
import '../utils/logger.dart';
import '../utils/utils.dart';

abstract class AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool get isAuthenticated => auth.currentUser != null;
  User? get user => auth.currentUser;
  void signOut() => auth.signOut();
}

class EmulatorAuthRepository extends AuthRepository {
  /// Run this method to use the localhost
  Future<void> init() async {
    // Use the http if neeed
    await auth.useAuthEmulator(Utils.localHost, 9099);
  }

  /// Create two account in the auth service
  ///
  /// As a tester, add the data each time the server is started I have
  /// to add the data manually so this method automatically add the data
  Future<void> createAccounts() async {
    final firstEmail = DataTest.emailOne;
    final secondEmail = DataTest.emailTwo;
    final password = DataTest.password;

    final oneUser =
        await SignUpWithEmail.execute(email: firstEmail, password: password);

    if (oneUser != null)
      Log.console('Error creating account: $firstEmail - $oneUser', L.E);

    final twoUser =
        await SignUpWithEmail.execute(email: secondEmail, password: password);

    if (twoUser != null)
      Log.console('Error creating account: $secondEmail - $twoUser', L.E);
  }
}
