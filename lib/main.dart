import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'core/repositories/auth_repository.dart';
// import 'core/repositories/firestore_repository.dart';
import 'core/utils/routes.dart';
import 'core/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // EmulatorAuthRepository.init();
  // EmulatorFirestoreRepository.init();
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
