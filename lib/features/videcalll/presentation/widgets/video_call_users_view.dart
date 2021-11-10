import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videocalling_app/core/utils/logger.dart';
import 'package:videocalling_app/core/widgets/mini_widgets.dart';

import '../getX/videocall_controller.dart';

/// The full screen to see all the users in the screen
class VideoCallUserView extends StatelessWidget {
  const VideoCallUserView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallController>(builder: (c) {
      final views = c.views;

      Log.console('Total views: $views');

      if (views.isEmpty)
        return const CenterText(
          'Waiting for the users...',
          color: Colors.white,
        );

      if (views.length == 1)
        return const CenterText(
          'Waiting for the other user...',
          color: Colors.white,
        );

      //  assert(views.length == 2, 'Must be 2 users in this call. No more.');

      // NOTE: To see what is happening in the video call, use a grid to show each camera

      Widget currentUser = views[0];
      Widget guestUser = views[1];

      if (!c.defaultView) {
        currentUser = views[1];
        guestUser = views[0];
      }
      return Container(
        color: Colors.green,
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            _FullScreenUser(user: guestUser),
            _MiniScreenUser(user: currentUser),
          ],
        ),
      );
    });
  }
}

/// This class is inside of a stack
class _FullScreenUser extends StatelessWidget {
  const _FullScreenUser({Key? key, required this.user}) : super(key: key);

  /// The user to display
  final Widget user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 5,
        ),
      ),
      child: user,
    );
  }
}

class _MiniScreenUser extends StatelessWidget {
  const _MiniScreenUser({Key? key, required this.user}) : super(key: key);

  /// The user to display
  final Widget user;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120,
      left: 30,
      child: Container(
        width: 120,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.yellow,
            width: 5,
          ),
        ),
        child: user,
      ),
    );
  }
}
