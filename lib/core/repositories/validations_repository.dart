import 'package:get/utils.dart';

abstract class ValidationsRepository {
  /// Return `true` if this email is valid
  static bool email(String email) => GetUtils.isEmail(email);

  /// Return `true` if this password is valid
  static bool password(String password) {
    if (password.length >= 6) return true;
    return false;
  }

  /// Return `true` if this name is valid
  static bool name(String name) {
    final names = name.split(" ");

    if (names.length < 2) return false;

    bool isValid = true;

    for (String n in names) {
      if (n.length < 2) {
        isValid = false;
        break;
      }
    }

    return isValid;
  }

  /// Return `true` if this username is valid
  static bool username(String username) => GetUtils.isUsername(username);
}
