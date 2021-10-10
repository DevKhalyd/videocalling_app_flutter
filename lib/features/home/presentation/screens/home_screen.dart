import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getX/home_controller.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              children: [
                // Appbar
                HomeAppBar(),
                // Body
                GetBuilder<HomeController>(
                  assignId: true,
                  id: HomeController.idUnique,
                  builder: (c) {
                    return Expanded(child: c.currentPage);
                  },
                ),
                // Bottombar
                HomeBottomNavigation(),
              ],
            ),
          ),
        );
      },
    );
  }
}
