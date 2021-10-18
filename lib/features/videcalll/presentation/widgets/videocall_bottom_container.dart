import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/mini_widgets.dart';
import 'hang_up_icon.dart';

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
            child: _VideoBottomAction(),
          ),
          Positioned(
            right: 0,
            left: 0,
            child: HangUpIcon(),
          ),
        ],
      ),
    );
  }
}

/// Contains the actions of the app bar
class _VideoBottomAction extends StatelessWidget {
  const _VideoBottomAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Space(0.02),
                  TextCustom('Manuel Clayton'),
                  Space(0.01),
                  TextCustom('24 : 30'),
                ],
              ),
            ),
            Expanded(
              child: BottomAction(
                icon: Icons.cameraswitch,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomAction extends StatelessWidget {
  const BottomAction({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: Colors.white,
            )),
      ),
    );
  }
}

/// Draws the container for this one
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
