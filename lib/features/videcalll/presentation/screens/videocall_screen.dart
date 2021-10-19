import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../../../core/utils/utils.dart';
import '../getX/videocall_controller.dart';
import '../widgets/videocall_bottom_container.dart';

class VideocallScreen extends StatelessWidget {
  const VideocallScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: VideoCallControlller(),
        builder: (c) {
          return Scaffold(
            backgroundColor: Utils.textFormFIeldColor,
            body: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: BackButton(color: Colors.white),
                  ),
                  // Use a stakc
                  // The video screen
                  Spacer(),
                  // Options
                  // Bottom bar
                  VideoCallBottomContainer(),
                ],
              ),
            ),
          );
        });
  }
}
