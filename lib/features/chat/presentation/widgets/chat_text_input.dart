import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getX/chat_controller.dart';

class ChatTextInput extends StatelessWidget {
  const ChatTextInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (c) {
        /// TODO: Make the design for this form field
        /// Manage its own state
        return TextFormField();
      },
    );
  }
}
