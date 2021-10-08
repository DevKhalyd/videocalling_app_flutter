import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videocalling_app/core/utils/routes.dart';

import '../../../../core/repositories/validations_repository.dart';
import '../../../../core/widgets/dialogs/info_dialog.dart';
import '../../domain/usecases/sign_in_email.dart';

class SignInController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _isLoading = false;

  GlobalKey<FormState> get formKey => _formKey;
  AutovalidateMode get autovalidateMode => _autovalidateMode;
  bool get isLoading => _isLoading;

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

  void onSignIn() async {
    final state = formKey.currentState!;

    if (!state.validate()) {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
      update();
      return;
    }

    // Save the data necessary to login
    state.save();

    _loadingState(true);
    final msg =
        await SignInWithEmail.execute(email: _email, password: _password);
    _loadingState();
    if (msg is String) {
      Get.dialog(AlertInfo(content: msg));
      return;
    }
    Get.offNamed(Routes.home);
  }

  /// Change the value of isLoading
  _loadingState([bool value = false]) {
    if (value == _isLoading) return;
    _isLoading = value;
    update();
  }

  void onSignUpUser() => Get.toNamed(Routes.signUp);
}
