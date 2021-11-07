import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'hang_up_video_call_btn.dart';
import 'videocall_bottom_actions.dart';

/// Size of the actions
const _sizeActions = 110.0;

class VideoCallBottomContainer extends StatelessWidget {
  const VideoCallBottomContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: _sizeActions + 40,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: VideoCallBottomActions(),
          ),
          Positioned(
            right: 0,
            left: 0,
            child: HangUpVideoCallButton(),
          ),
        ],
      ),
    );
  }
}
