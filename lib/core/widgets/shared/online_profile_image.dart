import 'package:flutter/material.dart';
import 'circle_profile_image.dart';
import 'dot.dart';

/// Show with a mini dot if a profile is online or offline
class OnlineProfileImage extends StatelessWidget {
  const OnlineProfileImage({
    Key? key,
    required this.isOnline,
    required this.profile,
  }) : super(key: key);

  final CircleProfileImage profile;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          profile,
          Positioned(
            top: -2,
            right: 0,
            child: Dot(
              color: isOnline ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
