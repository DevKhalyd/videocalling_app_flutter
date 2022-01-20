import 'package:flutter/material.dart';

import '../../domain/models/message.dart';
import 'chat_bubble.dart';

// TODO: Test this part

class ChatMessageItem extends StatelessWidget {
  const ChatMessageItem({
    Key? key,
    required this.idThisUser,
    required this.message,
  }) : super(key: key);

  final Message message;

  /// The user who is signed in this session
  final String idThisUser;

  @override
  Widget build(BuildContext context) {
    /// This user send the message
    final isThisUser = idThisUser == message.idUser;

    return ChatBubble(
      isRight: isThisUser,
      message: message.data,
      time: message.getReadableDate(),
    );
  }
}
