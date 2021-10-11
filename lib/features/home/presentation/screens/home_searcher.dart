import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/mini_widgets.dart';
import '../../../../core/widgets/shared/app_bar_custom.dart';
import '../getX/home_search_controller.dart';

class HomeSearcher extends StatelessWidget {
  /// Show a screen to search by usernames given by the user. Show basic data.
  const HomeSearcher({Key? key}) : super(key: key);

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
                TextFormField(
                  controller: c.controller,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Search',
                  ),
                ),
                Space(0.015),
                _BodyHomeResearcher()
              ],
            )),
          );
        });
  }
}

class _BodyHomeResearcher extends StatelessWidget {
  const _BodyHomeResearcher({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Make some validations to start to listen to this changes...
    return Expanded(
        child: ListView.builder(
            itemCount: 0,
            itemBuilder: (_, i) {
              return Container();
            }));
  }
}
