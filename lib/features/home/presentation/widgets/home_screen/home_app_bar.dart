import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/widgets/mini_widgets.dart';
import '../../getX/home_controller.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      width: context.width,
      child: Row(
        children: [
          Space(0.05, isHorizontal: true),
          GetBuilder<HomeController>(
            assignId: true,
            id: HomeController.idUnique,
            builder: (c) {
              return TextCustom(
                c.title,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              );
            },
          ),
          Spacer(),
          GetBuilder<HomeController>(
            builder: (c) {
              return c.getImageAppbar();
            },
          ),
          Space(0.02, isHorizontal: true),
        ],
      ),
    );
  }
}
