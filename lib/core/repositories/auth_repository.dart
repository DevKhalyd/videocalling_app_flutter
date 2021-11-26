import 'package:firebase_auth/firebase_auth.dart';
import 'package:videocalling_app/core/utils/utils.dart';

abstract class AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool get isAuthenticated => auth.currentUser != null;
  User? get user => auth.currentUser;
  void signOut() => auth.signOut();
}

class EmulatorAuthRepository extends AuthRepository {
  EmulatorAuthRepository.init() {
    // Use the http if neeed
    auth.useAuthEmulator(Utils.localHost, 9099);
  }
}
