import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getX/videocall_controller.dart';
import 'bottom_action.dart';
import 'diagonal_shape.dart';

/// Related to [VideoCallController].
///
/// Show when the microphone is enable.
///
/// This widget is used when the call is ongoing.
class MicroPhoneIcon extends StatelessWidget {
  const MicroPhoneIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallController>(
      builder: (c) {
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            BottomAction(
              icon: Icons.mic,
              tooltip: c.muted ? 'Unmute' : 'Mute',
              onPressed: c.onPressMicroPhone,
            ),
            if (c.muted) DiagonalShape(),
          ],
        );
      },
    );
  }
}
