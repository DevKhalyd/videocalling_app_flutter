// Chat design:
//https://dribbble.com/shots/8094338-Chat-App

import 'package:flutter/material.dart';
import 'package:videocalling_app/core/extensions/context_ext.dart';
import 'package:videocalling_app/core/utils/utils.dart';
import 'package:videocalling_app/core/widgets/mini_widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Components',
      home: Scaffold(
        backgroundColor: Utils.textFormFIeldColor,
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: ChatMessage(),
        ),
      ),
    );
  }
}

const _radius = 32.0;

/// The space to show a message in the chat
class ChatMessage extends StatelessWidget {
  const ChatMessage({Key? key, this.isRight = true}) : super(key: key);

  final bool isRight;

  @override
  Widget build(BuildContext context) {
    final width = context.width * 0.6;

    print("width message: $width");

    return Container(
      width: width,
      decoration: BoxDecoration(
        // TODO: Add constraints to the chat bubble for large screens
        color: Colors.purple,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(!isRight ? _radius : 0),
          bottomRight: Radius.circular(isRight ? _radius : 0),
          topRight: Radius.circular(_radius),
          bottomLeft: Radius.circular(_radius),
        ),
      ),
      padding: const EdgeInsets.all(18.0),
      child: TextCustom(
          'Hello There.... asdadsadsa asdasdasdasd sdsadasdsad asdsadsadasds'),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, this.date = '12 : 02'}) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextCustom(date),
        SizedBox(width: 8),
        ChatMessage(),
      ],
    );
  }
}
