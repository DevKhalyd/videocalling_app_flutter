import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:videocalling_app/core/repositories/audio_player_repository.dart';

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
  // test each sound
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onCallingTone,
        child: Text('Play Sound'),
      ),
    );
  }

  onCallingTone() {
    if (isSilent) {
      AudioPlayerRepository.loopCallingRingtone();
      isSilent = false;
    } else {
      AudioPlayerRepository.stopCallingRingtone();
      isSilent = true;
    }
  }

  onRingtone() {
    if (isSilent) {
      FlutterRingtonePlayer.playRingtone();
      isSilent = false;
    } else {
      FlutterRingtonePlayer.stop();
      isSilent = true;
    }
  }
}
