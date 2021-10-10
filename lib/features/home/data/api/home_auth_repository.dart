import '../../../../core/repositories/auth_repository.dart';

class HomeAuthRepository extends AuthRepository {
  /// Return the email of the authenticated user.
  String? getUserEmail() => user?.email;

  void signOutUser() => signOut();
}
