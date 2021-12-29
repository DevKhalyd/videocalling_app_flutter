import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../messages/domain/models/message_state.dart';
import '../../../messages/domain/models/message_type.dart';
import '../../domain/models/message.dart';
import '../../domain/usecases/send_message.dart';
import '../getX/chat_controller.dart';

class ChatTextInput extends StatefulWidget {
  const ChatTextInput({Key? key}) : super(key: key);

  @override
  State<ChatTextInput> createState() => _ChatTextInputState();
}

class _ChatTextInputState extends State<ChatTextInput> {
  final textController = TextEditingController();

  bool hasText = false;

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      final text = textController.text;
      if (text.isEmpty) {
        changeState(false);
        return;
      }
      changeState(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (c) {
        return Container(
            height: kToolbarHeight,
            width: context.width,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white54,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(
                        color: Colors.white54,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: hasText ? onPressedSendIcon : null,
                  icon: Icon(Icons.send),
                ),
              ],
            ));
      },
    );
  }

  // TODO: Test the send message usecase
  void onPressedSendIcon() {
    final msg = Message(
      idUser: ChatController.to.user.id,
      data: textController.text,
      messageType: MessageType.textType(),

      /// Because from the first moment send the message
      messageState: MessageState.deliveredState(),
    );

    SendMessage.execute(ChatController.to.idConversation, msg);
    textController.clear();
  }

  /// Enable or disable the send icon
  changeState([bool value = true]) {
    if (hasText == value) return;
    setState(() {
      hasText = value;
    });
  }
}
