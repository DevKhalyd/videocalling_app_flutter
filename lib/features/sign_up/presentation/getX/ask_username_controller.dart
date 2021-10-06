import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../core/repositories/validations_repository.dart';

class AskUsernameController extends GetxController {
  final _controller = TextEditingController();
  final delayed = Debouncer(delay: Duration(seconds: 1));
  TextEditingController get controller => _controller;

  bool _isLookingUp = false;
  bool _isLoading = false;
  bool _isEnabled = false;
  bool _usernameIsAvaible = false;

  /// When the application is verifying if the username is avaible
  bool get isLookingUp => _isLookingUp;

  /// When the user press the sign up button
  bool get isLoading => _isLoading;

  /// If the button sign up is enabled
  bool get isEnabled => _isEnabled;

  void signUp() async {}

  @override
  void onReady() {
    _controller.addListener(() {
      delayed(() {
        final text = controller.text;
        if (text.length < 3) return;
        
      });
    });
    super.onReady();
  }

  // 1. TODO: Research for the username in the database

  // 2. TODO: Disabled / Enabled the button

  _usernameState([bool value = false]) {
    if (value == _usernameIsAvaible) return;
    _usernameIsAvaible = value;
    update();
  }

  String? onValidation(String? v) {
    if (v == null) return null;
    if (!ValidationsRepository.username(v) && v.length > 2)
      return 'Username not valid';
  }
}
