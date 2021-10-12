import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../utils/utils.dart';
import '../mini_widgets.dart';

class AlertOption extends StatelessWidget {
  /// Select between YES or NO
  ///
  /// Return `true` if the choosed option is YES
  const AlertOption({
    Key? key,
    required this.content,
    this.title = 'Confirm',
  }) : super(key: key);

  final String title, content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Utils.textFormFIeldColor,
      title: TextCustom(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[TextCustom(content)],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: TextCustom(
            'No',
            color: Utils.acentColor,
          ),
          onPressed: () => Get.back(result: false),
        ),
        TextButton(
          child: TextCustom(
            'Yes',
            color: Utils.acentColor,
          ),
          onPressed: () => Get.back(result: true),
        ),
      ],
    );
  }
}
