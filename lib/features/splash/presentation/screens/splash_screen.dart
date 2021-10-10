import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videocalling_app/core/utils/utils.dart';

import '../../../../core/widgets/mini_widgets.dart';
import '../getX/splash_controller.dart';

/// The first screen to appears
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Utils.textFormFIeldColor,
        body: GetBuilder<SplashController>(
            init: SplashController(),
            builder: (c) {
              final showProgressIndicator = c.showProgressIndicator;
              return Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextCustom(
                      'VC',
                      fontSize: 50,
                      letterSpacing: 7.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Knewave-Regular',
                    ),
                    if (showProgressIndicator) Space(0.05),
                    if (showProgressIndicator)
                      CircularProgressCustom(color: Colors.white),
                  ],
                ),
              );
            }));
  }
}
