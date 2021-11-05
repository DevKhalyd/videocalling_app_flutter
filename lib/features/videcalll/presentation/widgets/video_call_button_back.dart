import 'package:flutter/material.dart';

import '../getX/videocall_controller.dart';

class VideoCallButtonBack extends StatelessWidget {
  const VideoCallButtonBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 56,
        left: 16,
        child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => VideoCallController.to.onEndCall));
  }
}
