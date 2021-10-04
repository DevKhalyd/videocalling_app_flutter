import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/repositories/validations_repository.dart';
import '../../../../core/routes.dart';

class SignInController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  String _email = '';
  String _password = '';

  String? onValidatorEmail(String? email) {
    if (email == null) return 'Invalid e-mail';

    if (ValidationsRepository.email(email)) return null;

    return 'E-mail not valid';
  }

  String? onValidatorPassword(String? password) {
    if (password == null) return 'Invalid password';
    if (ValidationsRepository.password(password)) return null;
    return 'Password not valid';
  }

  // In the on saved methods always the email is non-null
  // because before to save the method validate is executed.
  void onSaveEmail(String? email) => _email = email!;

  void onSavePassword(String? password) => _password = password!;

  void onSignIn() {
    final state = formKey.currentState!;

    if (!state.validate()) {
      return;
    }
    // Save the data...


  }

  void onSignUpUser() => Get.toNamed(Routes.signUp);
}
