import 'package:videocalling_app/features/home/data/api/home_auth_repository.dart';

abstract class GetEmailUser {
  /// If returns null means that the user is not authenticated
  static String? execute() {
    final repo = HomeAuthRepository();
    return repo.getUserEmail();
  }
}
