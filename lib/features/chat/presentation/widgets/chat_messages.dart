import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../core/widgets/mini_widgets.dart';
import '../../domain/models/message.dart';
import '../getX/chat_controller.dart';

/// Where all the messages appears
class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (c) {
      final streamMessages = c.messages;
      return StreamBuilderCustom<List<Message>>(
        stream: streamMessages,
        onData: (_, snapshot) {
          final messages = snapshot.data ?? [];

          if (messages.isEmpty)
            return Expanded(
              child: IconDescription(Icons.message, 'No messages'),
            );

          return Expanded(
            child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (c, index) {
                  final message = messages[index];
                  // TODO: Create the message widget for this user...
                  return TextCustom(message.data);
                }),
          );
        },
      );
    });
  }
}
