import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../core/repositories/validations_repository.dart';
import '../../../../core/shared/models/user/user.dart';
import '../../../../core/utils/arguments.dart';
import '../../../../core/utils/messages.dart';
import '../../../../core/utils/routes.dart';
import '../../../../core/widgets/dialogs/info_dialog.dart';
import '../../domain/usecases/add_user_data.dart';
import '../../domain/usecases/exits_username.dart';
import '../../domain/usecases/sign_up_with_email.dart';
import 'sign_up_controller.dart';

class AskUsernameController extends GetxController {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();
  final _delayed = Debouncer(delay: Duration(milliseconds: 500));
  final _delayedFocus = Debouncer(delay: Duration(milliseconds: 150));

  String _username = '';

  /// The last input by the user
  String _lastInput = '';
  bool _isLookingUp = false;
  bool _isLoading = false;
  bool _usernameIsAvaible = false;

  /// When the application is verifying if the username is avaible
  bool get isLookingUp => _isLookingUp;

  /// When the user press the sign up button
  bool get isLoading => _isLoading;

  /// If the button sign up is enabled
  bool get isEnabled => _usernameIsAvaible;

  TextEditingController get controller => _controller;

  FocusNode get focusNode => _focusNode;

  @override
  void onReady() {
    _controllerListener();
    _focusListener();
    super.onReady();
  }

  _focusListener() {
    /// Allow to update the UI according to the user's input
    _focusNode.addListener(() {
      _delayedFocus(() {
        if (!_usernameIsAvaible && _username.isNotEmpty) {
          _usernameAvaibleState(true);
        }
      });
    });
  }

  /// Check the username each time the user enters a new username
  ///
  /// Also update the UI
  _controllerListener() {
    _controller.addListener(() {
      _usernameAvaibleState();
      _delayed(() async {
        final text = controller.text;
        if (_lastInput == text || !_isValidUserName(text)) return;
        _username = '';
        _lookingUpState(true);
        final exists = await ExistsUsername.execute(username: text);
        _lookingUpState();
        _lastInput = text;
        if (exists == null) {
          Get.dialog(AlertInfo(content: Messages.error));
          return;
        }
        _usernameAvaibleState(!exists);
        if (exists)
          Get.dialog(AlertInfo(content: Messages.usernameUnavaible));
        else
          _username = text;
      });
    });
  }

  void signUp() async {
    if (_username.isEmpty) return;

    final userInfo = SignUpController.to.userInfo;

    _loadingState(true);

    final msg = await SignUpWithEmail.execute(
      email: userInfo.email,
      password: userInfo.password,
    );

    if (msg is String) {
      Get.dialog(AlertInfo(content: msg));
      _loadingState();
      return;
    }

    final wasDataAdded = await AddUserData.execute(
        user: User(
      username: _username,
      fullname: userInfo.name,
      email: userInfo.email,
      password: userInfo.password,
    ));

    _loadingState();

    if (wasDataAdded) {
      Get.offNamed(Routes.home, arguments: Arguments.openImagePicker);
      return;
    }
    Get.dialog(AlertInfo(content: Messages.error));
  }

  /// Change the value of [_usernameIsAvaible]
  _usernameAvaibleState([bool value = false]) {
    if (value == _usernameIsAvaible) return;
    _usernameIsAvaible = value;
    update();
  }

  /// Change the value of [_isLookingUp]
  _lookingUpState([bool value = false]) {
    if (value == _isLookingUp) return;
    _isLookingUp = value;
    update();
  }

  void _loadingState([bool value = false]) {
    if (value == _isLoading) return;
    _isLoading = value;
    update();
  }

  String? onValidation(String? v) {
    if (v == null) return null;
    if (!ValidationsRepository.username(v) || v.length < 3)
      return 'Username not valid';
  }

  bool _isValidUserName(String v) => onValidation(v) == null;
}
