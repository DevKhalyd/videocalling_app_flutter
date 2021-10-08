import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getX/home_controller.dart';
import '../widgets/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (c) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              // Appbar
              HomeAppBar(),
              // Body
              Expanded(child: c.currentPage),
              // Bottombar
              
            ],
          ),
        );
      },
    );
  }
}
