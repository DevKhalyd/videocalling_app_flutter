import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../core/shared/models/user/user.dart';
import '../../../../core/utils/messages.dart';
import '../../../../core/utils/routes.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/dialogs/info_dialog.dart';
import '../../domain/usecases/get_users_by_username.dart';
import 'home_controller.dart';

class HomeSearchController extends GetxController {
  final _debouncer = Debouncer(delay: Duration(milliseconds: 500));
  final _controller = TextEditingController();

  /// The last username entered by the user
  String _lastUsername = '';
  bool _hasInternet = true;

  TextEditingController get controller => _controller;
  Stream<List<User>>? _users;
  Stream<List<User>>? get users => _users;

  @override
  void onReady() {
    super.onReady();
    _listenerField();
    _checkInternetConnection();
  }

  _listenerField() => _controller.addListener(() {
        _debouncer(() async {
          final text = _controller.text;
          if (text.isEmpty || _lastUsername == text) return;
          _lastUsername = text;
          _users = GetUsersByUsername.execute(
              username: text,
              thisUsername: HomeController.to.user?.username ?? '');
          update();
        });
      });

  /// When this user select an user to call.
  void onPressUser(User u) async {
    if (!_hasInternet) {
      await Get.dialog(AlertInfo(content: Messages.noInternetConnection));
      _checkInternetConnection();
      return;
    }

    // Return to the home screen
    Get.back();
    // Open the videocalling screen
    Get.toNamed(Routes.videocall, arguments: u);
  }

  void _checkInternetConnection() async {
    final result = await Utils.hasInternetConnection();
    _hasInternet = result;
  }
}
