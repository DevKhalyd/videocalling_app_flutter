import 'package:flutter/material.dart';

import '../getX/videocall_controller.dart';

class VideoCallSwitchCameraViews extends StatelessWidget {
  const VideoCallSwitchCameraViews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 56,
        right: 16,
        child: GestureDetector(
            onTap: VideoCallController.to.onChangeViews,
            child: Icon(
              Icons.flip_camera_android_outlined,
              color: Colors.white,
            )));
  }
}
