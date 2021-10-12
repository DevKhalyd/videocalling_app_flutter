import 'package:flutter/material.dart';

import '../../../../../core/widgets/mini_widgets.dart';
import '../../../../../core/widgets/shared/circle_profile_image.dart';
import '../../../../../core/widgets/shared/online_profile_image.dart';

/// The item to show when the user is searching for a username
class TileHomeSearcher extends StatelessWidget {
  const TileHomeSearcher({
    Key? key,
    required this.username,
    required this.fullname,
    required this.isOnline,
    required this.profileImage,
    this.onPressed,
  }) : super(key: key);

  final String username, fullname;
  final bool isOnline;
  final CircleProfileImage profileImage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: OnlineProfileImage(
        profile: profileImage,
        isOnline: isOnline,
      ),
      title: TextCustom(
        username,
        fontWeight: FontWeight.bold,
      ),
      subtitle: TextCustom(
        fullname,
        color: Colors.grey,
      ),
      onTap: onPressed,
    );
  }
}
