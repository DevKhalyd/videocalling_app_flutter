import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/mini_widgets.dart';
import '../getX/home_controller.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) {
        return Container(
          height: kToolbarHeight,
          width: context.width,
          child: Row(
            children: [
              Space(0.01, isHorizontal: true),
              TextCustom(
                c.title,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              Spacer(),
              // TODO: Get the image url or the first letter to show here
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 30,
              ),
              Space(0.01, isHorizontal: true),
            ],
          ),
        );
      },
    );
  }
}
