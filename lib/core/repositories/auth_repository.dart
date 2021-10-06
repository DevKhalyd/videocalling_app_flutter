import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool get isAuthenticated => auth.currentUser != null;
}
