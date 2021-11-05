import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../utils/utils.dart';
import '../mini_widgets.dart';

/// Alert to show information about the app
class AlertInfo extends StatelessWidget {
  const AlertInfo({
    Key? key,
    required this.content,
    this.title = 'Info',
    this.button = 'OK',
  }) : super(key: key);

  final String title, content, button;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Utils.textFormFIeldColor,
      title: TextCustom(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextCustom(content, color: Colors.white),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: TextCustom(
            button,
            color: Utils.acentColor,
          ),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}
