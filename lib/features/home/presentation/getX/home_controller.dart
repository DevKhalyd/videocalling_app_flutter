import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/arguments.dart';
import '../../../calls/presentation/screens/calls_screen.dart';
import '../../../messages/presentation/screens/messages_screen.dart';
import '../screens/image_picker_screen.dart';

/// Handle each fragment in this screen
class HomeController extends GetxController {
  /// Pages to show
  final _pages = [
    MessagesScreen(),
    CallsScreen(),
  ];

  /// The app bar titles
  final _titles = [
    'Chatting',
    'Calls',
  ];

  /// The bottom names.
  final _tabs = [
    'Messages',
    'Calls',
  ];

  int _currentPage = 0;

  Widget get currentPage => _pages[_currentPage];
  String get title => _titles[_currentPage];
  String get tab => _tabs[_currentPage];

  @override
  void onReady() {
    super.onReady();
    _onReceiveArguments();
  }

  void _changeCurrentPage([int value = 0]) {
    if (value == _currentPage) return;
    _currentPage = value;
    update();
  }

  /// Do something if receive some arguments
  void _onReceiveArguments() {
    final arguments = Get.arguments;
    if (arguments is String) {
      switch (arguments) {
        case Arguments.openImagePicker:
          Get.to(ImagePickerScreen());
          break;
        default:
          throw UnimplementedError("Missing string to execute");
      }
    }
  }
}
