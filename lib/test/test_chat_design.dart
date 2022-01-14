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
          child: ChatBubble(
            bottomRightRadius: 0,
          ),
        ),
      ),
    );
  }
}

const _radius = 32.0;

/// The space to show a message in the chat
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    this.topLeftRadius = _radius,
    this.bottomRightRadius = _radius,
  })  : assert(topLeftRadius != bottomRightRadius),
        super(key: key);

  final double topLeftRadius, bottomRightRadius;

  @override
  Widget build(BuildContext context) {
    final width = context.width * 0.6;

    return Container(
      width: width,
      decoration: BoxDecoration(
        // TODO: Add constraints to the chat bubble for large screens
        // TODO: Add the date as the dessign suggest
        color: Colors.purple,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius),
          bottomRight: Radius.circular(bottomRightRadius),
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
