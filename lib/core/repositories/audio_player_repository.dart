import 'package:audioplayers/audioplayers.dart';

abstract class AudioPlayerRepository {
  static final AudioCache _audioCache = AudioCache(
    prefix: 'assets/sounds/',
  );

  static AudioPlayer? _audioPlayer;

  static void loopCallingRingtone() async {
    //await audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    final result = await _audioCache.loop('calling_tone.wav');
    _audioPlayer = result;
  }

  static void stopCallingRingtone() async {
    _audioPlayer?.stop();
  }
}
