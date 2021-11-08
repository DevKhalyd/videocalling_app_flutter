import 'package:flutter/material.dart';

import '../getX/videocall_controller.dart';

class VideoCallButtonBack extends StatelessWidget {
  const VideoCallButtonBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 8,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => VideoCallController.to.onEndCall,
        ));
  }
}
