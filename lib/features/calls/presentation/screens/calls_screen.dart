import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';
import '../getX/calls_controller.dart.dart';

class CallsScreen extends StatelessWidget {
  /// Show the history of the calls for this user
  const CallsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.textFormFIeldColor,
      body: GetBuilder<CallsController>(
        init: CallsController(),
        builder: (c) {
          return Container();
        },
      ),
    );
  }
}
