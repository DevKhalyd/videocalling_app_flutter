// Chat design:
//https://dribbble.com/shots/8094338-Chat-App

import 'package:flutter/material.dart';
import 'package:videocalling_app/core/utils/utils.dart';
 import 'package:videocalling_app/features/chat/presentation/widgets/chat_bubble.dart';

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
        body: ChatBubble(
          isRight: true,
          message: 'Hello',
          time: '12:00',
        ),
      ),
    );
  }
}


