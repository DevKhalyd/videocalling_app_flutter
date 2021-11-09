import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getX/videocall_controller.dart';

const _size = 60.0;

class HangUpVideoCallButton extends StatelessWidget {
  const HangUpVideoCallButton({
    Key? key,
    this.size = _size,
    this.onPressed,
  }) : super(key: key);

  final double size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallController>(
      builder: (c) {
        final isReceiver = c.isReceiver;

        return Material(
          color: isReceiver && !c.isOnCall ? Colors.green : Colors.red,
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: IconButton(
                onPressed: () =>
                    c.shouldAnswerCall ? c.onAnswerCall() : c.onEndCall(),
                icon: Icon(
                  isReceiver ? Icons.call_sharp : Icons.call_end,
                  color: Colors.white,
                )),
          ),
        );
      },
    );
  }
}
