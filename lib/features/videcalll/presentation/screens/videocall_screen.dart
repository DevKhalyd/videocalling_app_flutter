import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../../../core/utils/utils.dart';
import '../getX/videocall_controller.dart';
import '../widgets/video_call_button_back.dart';
import '../widgets/video_call_switch_camera.dart';
import '../widgets/video_call_users_view.dart';
import '../widgets/videocall_bottom_container.dart';

/// Contains the screen where the user interacts with other one
class VideocallScreen extends StatelessWidget {
  const VideocallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallController>(
        init: VideoCallController(),
        builder: (c) {
          final isOnCall = c.isOnCall;
          return Scaffold(
            backgroundColor: Utils.textFormFIeldColor,
            body: SafeArea(
                child: Stack(
              children: [
                /// Button back
                VideoCallUserView(),
                VideoCallButtonBack(),
                if (isOnCall) VideoCallSwitchCameraViews(),

                /// Actions
                VideoCallBottomContainer(),
              ],
            )),
          );
        });
  }
}
