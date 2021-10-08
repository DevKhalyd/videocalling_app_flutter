import 'package:get/get.dart';

/// Handle the whole screen
class HomeController extends GetxController {
  static HomeController get to => Get.find();

  @override
  void onReady() {
    // If any then show an screen asking for the url.
    final arguments = Get.arguments;

    if (arguments is String) {
      
    }

    super.onReady();
  }
}
