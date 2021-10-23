import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'core/repositories/auth_repository.dart';
// import 'core/repositories/firestore_repository.dart';
import 'core/utils/firebase_initalizer.dart';
import 'core/utils/routes.dart';
import 'core/utils/utils.dart';

void main() async {
  await FirebaseInitializer.execute();
  runApp(VideocallingApp());
}

class VideocallingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(iconTheme: IconThemeData(color: Colors.white)),
      title: Utils.appName,
      initialRoute: Routes.initial,
      getPages: Routes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
