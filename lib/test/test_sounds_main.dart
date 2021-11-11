import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Sounds App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test Sounds App Bar'),
        ),
        body: _Item(),
      ),
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({
    Key? key,
  }) : super(key: key);

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  bool isSilent = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          if (isSilent) {
            FlutterRingtonePlayer.playRingtone();
            isSilent = false;
          } else {
            FlutterRingtonePlayer.stop();
            isSilent = true;
          }
        },
        child: Text('Play Sound'),
      ),
    );
  }
}
