import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';
import '../getX/chat_controller.dart';
import '../widgets/chat_app_bar.dart';

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
              // TODO: Create the screen of each message.
              Expanded(child: Container()),
              // TODO: Create the input in the server.
              Container(),
            ],
          )),
        );
      },
    );
  }
}
