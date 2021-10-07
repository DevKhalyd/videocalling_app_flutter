import 'dart:async';

import 'package:get/get.dart';

import '../../../../core/routes.dart';
import '../../domain/usecases/is_sign.dart';

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
    Timer(Duration(milliseconds: 750), () {
      final isAuthenticated = IsAuthenticated.execute();
      if (isAuthenticated)
        Get.offAllNamed(Routes.home);
      else
        Get.offNamed(Routes.signIn);
    });
    super.onReady();
  }
}
