import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../../core/shared/models/user/user.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/usecases/get_users_by_username.dart';

class HomeSearchController extends GetxController {
  final _debouncer = Debouncer(delay: Duration(milliseconds: 500));
  final _controller = TextEditingController();

  /// The last username entered by the user
  String _lastUsername = '';

  TextEditingController get controller => _controller;
  Stream<List<User>>? _users;
  Stream<List<User>>? get users => _users;

  @override
  void onReady() {
    super.onReady();
    listenerField();
  }

  void listenerField() => _controller.addListener(() {
        _debouncer(() async {
          final text = _controller.text;
          if (text.isEmpty || _lastUsername == text) return;
          _lastUsername = text;
          Log.console('Searching by: $text');
          _users = GetUsersByUsername.execute(text);
          update();
        });
      });
}
