import 'package:videocalling_app/core/repositories/auth_repository.dart';

class SplashRepository extends AuthRepository {
  bool isUserAuthenticated() => isAuthenticated;
}
