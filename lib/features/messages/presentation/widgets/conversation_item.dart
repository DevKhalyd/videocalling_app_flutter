import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/mini_widgets.dart';
import '../../domain/models/conversation.dart';
import 'messages_unreaded.dart';

// TODO: Implement all of this, after of the test...
// https://dribbble.com/shots/8094338-Chat-App

/// According to the data given by the stream the
/// item should be updated
class ConversationItem extends StatelessWidget {
  const ConversationItem({Key? key, required this.conversation})
      : super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
            NetworkImage(conversation.imgUrl ?? Utils.defaultProfileImg),
      ),
      title: TextCustom(conversation.fullname),
      subtitle: TextCustom(conversation.lastMessage.getMessage()),
      trailing: getTrailing(),
    );
  }

  /// Show the unreaded messages
  Widget? getTrailing() {
    final amount = conversation.lastMessage.acumalativeMessages;
    if (amount > 0) return MessagesUnreaded(unreaded: amount);
  }
}
