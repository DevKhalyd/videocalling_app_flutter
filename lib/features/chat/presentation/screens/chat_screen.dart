import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videocalling_app/features/chat/presentation/widgets/chat_app_bar.dart';

import '../../../../core/utils/utils.dart';
import '../getX/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (c) {
        return Scaffold(
          backgroundColor: Utils.textFormFIeldColor,
          body: SafeArea(
              child: Column(
            children: [
              ChatAppBar(),
              // Chat. TODO: Liste to the messages
              Expanded(
                  child: Container(
                color: Colors.red,
              )),
              // Input
              Container(
                height: 60,
              ),
            ],
          )),
        );
      },
    );
  }
}
