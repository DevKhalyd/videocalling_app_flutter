import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:videocalling_app/core/widgets/mini_widgets.dart';

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
      title: TextCustom(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[TextCustom(content)],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(button),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}
