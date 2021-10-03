import 'dart:async';

import 'package:get/get.dart';
import 'package:videocalling_app/core/routes.dart';

class SplashController extends GetxController {
  bool showProgressIndicator = false;

  @override
  void onInit() {
    Timer(Duration(milliseconds: 3750), () {
      showProgressIndicator = true;
      update();
    });
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: Create the logic to know where go
    Timer(Duration(milliseconds: 1550), () {
      Get.offNamed(Routes.signIn);
    });
    super.onReady();
  }
}
