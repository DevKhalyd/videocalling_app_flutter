import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/mini_widgets.dart';
import '../getX/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (c) {
        return Scaffold(
          body: CenterText('Center Data and custom this one'),
        );
      },
    );
  }
}
