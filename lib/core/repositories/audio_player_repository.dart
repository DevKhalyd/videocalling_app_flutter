import 'package:audioplayers/audioplayers.dart';

abstract class AudioPlayerRepository {
  static final AudioCache _audioCache =
      AudioCache(prefix: 'assets/sounds/', fixedPlayer: _audioPlayer);

  static AudioPlayer _audioPlayer = AudioPlayer();

  static void loopCallingRingtone() async {
    await _audioCache.loop('calling_tone.wav');
  }

  static void stopCallingRingtone() async {
    _audioPlayer.stop();
  }
}
