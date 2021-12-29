import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../core/utils/logger.dart';
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

          // TODO: Once time the send message use case is ready, show the messages...
          Log.console('Total messages: ${messages.length}');
          return Expanded(child: Container());
        },
      );
    });
  }
}
