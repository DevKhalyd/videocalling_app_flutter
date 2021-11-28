import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/mini_widgets.dart';
import '../getX/home_controller.dart';
import '../widgets/home_screen/home_app_bar.dart';
import '../widgets/home_screen/home_bottom_navigation.dart';

/// Contains the main screen application.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // As personal note. Worth if I use GetX? Because I ended up using the native methods of flutter.
    // Maybe I need to change to another state managment for flutter. IDK.

    // Because If a notification arrives when the app is resumed those lines are necessary.
    // Resumed is not fired when the view is created. Instead is fired when go from paused | inactive to resumed.
    if (state == AppLifecycleState.resumed) {
      log('Check the latest message from the resumed state');
      HomeController.to.checkForLatestFCMessages();
    }
  }

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
