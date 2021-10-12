import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/mini_widgets.dart';
import '../../../../core/widgets/shared/app_bar_custom.dart';
import '../getX/home_search_controller.dart';
import '../widgets/home_searcher/body_home_searcher.dart';

class HomeSearcherScreen extends StatelessWidget {
  /// Show a screen to search by usernames given by the user. Show basic data.
  const HomeSearcherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeSearchController>(
        init: HomeSearchController(),
        builder: (c) {
          return Scaffold(
            backgroundColor: Utils.textFormFIeldColor,
            body: SafeArea(
                child: Column(
              children: [
                Space(0.02),
                AppBarCustom(title: 'Enter a username to call'),
                Space(0.015),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: c.controller,
                    cursorColor: Colors.purple,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type: username',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Space(0.015),
                BodyHomeSearcher()
              ],
            )),
          );
        });
  }
}
