import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/mini_widgets.dart';
import '../getX/videocall_controller.dart';
import 'bottom_action.dart';

const _sizeActions = 110.0;

/// Contains the actions of the app bar like the micrphone and switch camera
class VideoCallBottomActions extends StatelessWidget {
  const VideoCallBottomActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallController>(
      builder: (c) {
        return CustomPaint(
          painter: _PathPainter(),
          child: Container(
            height: _sizeActions,
            width: context.width,
            child: Row(
              children: [
                Expanded(
                  child: BottomAction(
                    icon: Icons.mic,
                    onPressed: c.onPressMicroPhone,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Space(0.025),
                      TextCustom(c.name),
                      Space(0.0085),
                      TextCustom(c.state),
                    ],
                  ),
                ),
                Expanded(
                  child: BottomAction(
                    icon: Icons.cameraswitch,
                    onPressed: c.onPressCamerasSwitch,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Draws the container for this bottom bar
class _PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;

    Paint paint = Paint()
      ..color = Utils.acentColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    Path path = Path();

    path.lineTo(width * .37, 0);

    path.quadraticBezierTo(width * .5, height * .6, width * .63, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
