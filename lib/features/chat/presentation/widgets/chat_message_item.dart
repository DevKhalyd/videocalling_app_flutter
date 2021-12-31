import 'package:flutter/material.dart';

import '../../../../core/widgets/mini_widgets.dart';
import '../../domain/models/message.dart';

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
    // TODO: Identify what type of message it is

    /// This user send the message
    final isThisUser = idThisUser == message.idUser;
    return Align(
        alignment: isThisUser ? Alignment.centerRight : Alignment.centerLeft,
        child: TextCustom(message.data));
  }
}
