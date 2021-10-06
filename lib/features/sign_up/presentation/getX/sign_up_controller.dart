import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/repositories/validations_repository.dart';
import '../../../../core/routes.dart';
import '../../domain/bridges/user_basic_info.dart';

class SignUpController extends GetxController {
  late UserBasicInfo _userInfo;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  GlobalKey<FormState> get formKey => _formKey;
  AutovalidateMode get autovalidateMode => _autovalidateMode;
  UserBasicInfo get userInfo => _userInfo;

  String _name = '';
  String _email = '';
  String _password = '';

  String? onValidatorName(String? name) {
    if (name == null) return 'Invalid name';

    if (ValidationsRepository.name(name)) return null;

    return 'Name not valid';
  }

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
  // because before to save the method validate is executed

  void onSaveName(String? name) => _name = name!;

  void onSaveEmail(String? email) => _email = email!;

  void onSavePassword(String? password) => _password = password!;

  void onContinue() async {
    final state = _formKey.currentState!;

    if (!state.validate()) {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
      update();
      return;
    }

    // Save the data necessary to signUp
    state.save();

    _userInfo = UserBasicInfo(
      email: _email,
      password: _password,
      name: _name,
    );

    Get.toNamed(Routes.askUserName);
  }

  void onSignInUser() => Get.back();
}
