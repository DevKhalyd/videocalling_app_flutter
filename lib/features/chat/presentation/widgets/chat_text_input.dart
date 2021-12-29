import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getX/chat_controller.dart';

class ChatTextInput extends StatelessWidget {
  const ChatTextInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (c) {
        // TODO: Create a space for this one... Expanded > Row ...
        /// Manage its own state
        return TextFormField(
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white54,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            hintText: 'Type a message...',
            hintStyle: TextStyle(
              color: Colors.white54,
            ),
            border: InputBorder.none,
          ),
        );
      },
    );
  }
}
