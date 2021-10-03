import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/routes.dart';
import 'core/utils.dart';

void main() => runApp(VideocallingApp());

class VideocallingApp extends StatelessWidget {
  // Dark theme always...
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(iconTheme: IconThemeData(color: Colors.purple)),
      title: Utils.appName,
      initialRoute: Routes.initial,
      getPages: Routes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
