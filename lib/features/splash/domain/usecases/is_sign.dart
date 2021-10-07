import 'package:videocalling_app/features/splash/data/splash_repository.dart';

abstract class IsAuthenticated {
  /// Return `true` if the user is authenticated
  static bool execute() {
    final repo = SplashRepository();
    return repo.isUserAuthenticated();
  }
}
