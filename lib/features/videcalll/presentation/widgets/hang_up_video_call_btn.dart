import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getX/videocall_controller.dart';

const _size = 60.0;

class HangUpVideoCallButtom extends StatelessWidget {
  const HangUpVideoCallButtom({
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
        return Material(
          color: Colors.red,
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: IconButton(
                onPressed: c.onPressHangUp,
                icon: Icon(
                  Icons.call_end,
                  color: Colors.white,
                )),
          ),
        );
      },
    );
  }
}
