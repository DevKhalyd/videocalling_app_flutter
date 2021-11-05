import 'package:agora_rtc_engine/rtc_engine.dart';

/// The data necessary to start the videocall.
class VideoCallingModel {
  const VideoCallingModel({
    required this.channel,
    required this.token,

    /// Default to this one. Because always should be a broadcaster
    this.role = ClientRole.Broadcaster,
  });

  /// Necessary to start the call
  final String channel, token;
  final ClientRole role;
}
