import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../core/messages.dart';
import '../../../../core/repositories/validations_repository.dart';
import '../../../../core/routes.dart';
import '../../../../core/shared/models/more/user.dart';
import '../../../../core/widgets/dialogs/info_dialog.dart';
import '../../domain/usecases/add_user_data.dart';
import '../../domain/usecases/exits_username.dart';
import '../../domain/usecases/sign_up_with_email.dart';
import 'sign_up_controller.dart';

class AskUsernameController extends GetxController {
  final _controller = TextEditingController();
  final delayed = Debouncer(delay: Duration(seconds: 1));

  String _username = '';
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

  @override
  void onReady() {
    /// Check the username each time the user enters a new username
    _controller.addListener(() {
      delayed(() async {
        final text = controller.text;
        _username = '';
        _usernameAvaibleState();
        if (text.length < 3) return;
        _lookingUpState(true);
        final isAvaible = await ExistsUsername.execute(username: text);
        _lookingUpState();
        if (isAvaible == null) {
          Get.dialog(AlertInfo(content: Messages.error));
          return;
        }
        _usernameAvaibleState(isAvaible);
        if (!isAvaible)
          Get.dialog(AlertInfo(content: Messages.usernameUnavaible));
        else
          _username = text;
      });
    });
    super.onReady();
  }

  void signUp() async {
    if (_username.isEmpty) return;
    final userInfo = SignUpController.to.userInfo;

    final msg = await SignUpWithEmail.execute(
      email: userInfo.email,
      password: userInfo.password,
    );

    if (msg is String) {
      Get.dialog(AlertInfo(content: msg));
      return;
    }

    final wasDataAdded = await AddUserData.execute(
        user: User(
      username: _username,
      fullname: userInfo.name,
      email: userInfo.email,
      password: userInfo.password,
      isOnline: true,
    ));

    if (wasDataAdded) {
      // TODO: Set the option to upload an image to the server.
      Get.toNamed(Routes.home);
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

  String? onValidation(String? v) {
    if (v == null) return null;
    if (!ValidationsRepository.username(v) && v.length > 2)
      return 'Username not valid';
  }
}
