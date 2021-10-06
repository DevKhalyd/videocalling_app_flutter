import '../../../../core/repositories/auth_repository.dart';

class SignUpRepository extends AuthRepository {
  Future<void> withEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (_) {
      rethrow;
    }
  }
}
