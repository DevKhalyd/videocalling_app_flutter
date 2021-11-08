import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/mini_widgets.dart';
import '../getX/home_controller.dart';
import '../widgets/home_screen/home_app_bar.dart';
import '../widgets/home_screen/home_bottom_navigation.dart';

/// Contains the main screen application.
class HomeScreen extends StatelessWidget {
const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return AnnotatedRegionCustom(
          value: SystemUiOverlayStyle(
            statusBarColor: Utils.textFormFIeldColor,
          ),
          child: Scaffold(
            backgroundColor: Utils.textFormFIeldColor,
            body: SafeArea(
              child: Column(
                children: [
                  // Appbar
                  HomeAppBar(),
                  // Body
                  GetBuilder<HomeController>(
                    assignId: true,
                    id: HomeController.idUnique,
                    builder: (c) => Expanded(child: c.currentPage),
                  ),
                  // Bottombar
                  HomeBottomNavigation(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
