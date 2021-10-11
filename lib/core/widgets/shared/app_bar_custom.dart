import 'package:flutter/material.dart';

import '../mini_widgets.dart';

/// Appbar with back button and a title
class AppBarCustom extends StatelessWidget {
  const AppBarCustom({
    Key? key,
    required this.title,
    this.appBarColor,
  }) : super(key: key);

  final Color? appBarColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      width: double.infinity,
      color: appBarColor,
      child: Row(
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: Colors.white,
              )),
          Space(0.01, isHorizontal: true),
          TextCustom(
            title,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ],
      ),
    );
  }
}
