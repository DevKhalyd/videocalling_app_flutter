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
