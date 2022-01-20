import 'package:flutter/material.dart';

import '../../../../core/extensions/context_ext.dart';
import '../../../../core/widgets/mini_widgets.dart';

/// The message showned in a bubble
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.message,
    required this.time,
    this.isRight = true,
  }) : super(key: key);

  final String time;
  final bool isRight;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment:
            isRight ? MainAxisAlignment.start : MainAxisAlignment.end,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!isRight) TextCustom(time),
          if (!isRight) SizedBox(width: 25),
          ChatMessage(isRight: isRight, message: message),
          if (isRight) SizedBox(width: 25),
          if (isRight) TextCustom(time),
        ],
      ),
    );
  }
}

const _radius = 32.0;

/// The space to show a message in the chat
class ChatMessage extends StatelessWidget {
  const ChatMessage({Key? key, this.isRight = true, required this.message})
      : super(key: key);

  /// Whether the message is from the right or left
  final bool isRight;
  final String message;

  @override
  Widget build(BuildContext context) {
    final width = context.width * 0.6;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(!isRight ? _radius : 0),
          bottomRight: Radius.circular(isRight ? _radius : 0),
          topRight: Radius.circular(_radius),
          bottomLeft: Radius.circular(_radius),
        ),
      ),
      padding: const EdgeInsets.all(18.0),
      child: TextCustom(message),
    );
  }
}
