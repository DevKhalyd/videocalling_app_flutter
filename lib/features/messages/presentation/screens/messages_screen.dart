import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/mini_widgets.dart';
import '../../domain/models/conversation.dart';
import '../getX/messages_controller.dart';
import '../widgets/conversation_item.dart';

/// Just show the current messages for this user
///
/// Check the [chat] feature to see the messages in each chat
class MessagesScreen extends StatelessWidget {
  /// Show the current messages for this user
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MessagesController(),
      builder: (c) {
        return Scaffold(
            backgroundColor: Utils.textFormFIeldColor,
            body:
                StreamBuilderCustom<List<Conversation>>(onData: (_, snapshot) {
              final data = snapshot.data;

              if (data?.isEmpty ?? true)
                return IconDescription(Icons.chat, 'No conversations found');

              final list = data!;

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, index) {
                  final item = list[index];
                  return ConversationItem(conversation: item);
                },
              );
            }));
      },
    );
  }
}
