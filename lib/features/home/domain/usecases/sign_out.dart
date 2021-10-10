import '../../data/api/home_auth_repository.dart';

abstract class SignOut {
  /// Sign out the user
  static void execute() {
    final repo = HomeAuthRepository();
    return repo.signOutUser();
  }
}
