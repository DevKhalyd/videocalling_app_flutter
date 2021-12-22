import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/mini_widgets.dart';
import '../../../../core/widgets/shared/circle_profile_image.dart';
import '../getX/chat_controller.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (c) {
        return Container(
          height: kToolbarHeight,
          width: double.infinity,
          child: Row(children: [
            CircleProfileImage(
              url: c.user.imageUrl,
              firstLetter: c.user.fullname[0],
            ),
            Space(0.01,isHorizontal: true,),
            Column(
              children: [
                TextCustom(
                  c.user.fullname,
                  fontWeight: FontWeight.bold,
                ),
                if (c.user.isOnline)
                  TextCustom(
                    'Online',
                    color: Colors.green,
                  ),
              ],
            )
          ]),
        );
      },
    );
  }
}
