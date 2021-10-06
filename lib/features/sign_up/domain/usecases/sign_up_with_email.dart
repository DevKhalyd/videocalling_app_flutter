import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/logger.dart';
import '../../data/api/sign_up_auth_repository.dart';

abstract class SignUpWithEmail {
  /// If return a string means that something went wrong and a message should be shown
  static Future<String?> execute(
      {required String email, required String password}) async {
    final repo = SignUpRepository();

    try {
      await repo.withEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final code = e.code;
      if (code == 'weak-password')
        return 'The password provided is too weak.';
      else if (code == 'email-already-in-use')
        return 'The account already exists for that email.';
      else {
        Log.console('FirebaseAuthException: $code', L.E, e);
        return 'Something went wrong. Try again later';
      }
    } catch (e) {
      Log.console('FirebaseAuthException: ${e.runtimeType}', L.E, e);
      return 'Something went wrong. Try again later';
    }
  }
}
