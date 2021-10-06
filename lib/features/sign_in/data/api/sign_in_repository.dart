import '../../../../core/repositories/auth_repository.dart';

/// Sign in the user with the providers of Firebase
class SignInRepository extends AuthRepository {
  Future<void> withEmailAndPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (_) {
      rethrow;
    }
  }
}
