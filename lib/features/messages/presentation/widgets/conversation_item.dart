import 'package:flutter/material.dart';

import '../../../../core/shared/models/user/user.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/mini_widgets.dart';
import '../../../chat/domain/models/chat_bridge.dart';
import '../../../home/presentation/getX/home_controller.dart';
import '../../domain/models/conversation.dart';
import 'messages_unreaded.dart';

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
      onTap: onTap,
    );
  }

  void onTap() {
    /// Because the conversation was created already,
    /// [Conversation] contains it
    final idConversation = conversation.id;
    final user = User(
      username: conversation.username,
      fullname: conversation.fullname,
      imageUrl: conversation.imgUrl,
    );
    user.setId(conversation.idUser);
    final c = ChatBridge(idConversation: idConversation, user: user);
    HomeController.to.onOpenChat(c);
  }

  /// Show the unreaded messages
  Widget? getTrailing() {
    final amount = conversation.lastMessage.acumalativeMsgs;
    if (amount > 0) return MessagesUnreaded(unreaded: amount);
  }
}
