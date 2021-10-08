import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/utils/logger.dart';
import '../../data/api/sign_in_repository.dart';

abstract class SignInWithEmail {
  /// If return null means that everything goes fine
  /// If return non-null means that a message should shown in the UI
  static Future<String?> execute(
      {required String email, required String password}) async {
    final _signInRepo = SignInRepository();
    try {
      await _signInRepo.withEmailAndPassword(email, password);
    } on FirebaseAuthException catch (e) {
      final code = e.code;

      if (code == 'user-not-found')
        return 'No user found for that email.';
      else if (code == 'wrong-password')
        return 'Credentials are incorret';
      else {
        Log.console('FirebaseAuthException: $code', L.E, e);
        return 'Something went wrong. Try again later';
      }
    } catch (e) {
      Log.console('Unknow exception: ${e.runtimeType}', L.E, e);
      return 'Something went wrong. Please try again.';
    }
  }
}
