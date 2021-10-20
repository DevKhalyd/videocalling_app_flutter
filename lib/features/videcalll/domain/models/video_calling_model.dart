import 'package:agora_rtc_engine/rtc_engine.dart';

class VideoCallingModel {
  const VideoCallingModel({
    required this.channelID,
    required this.token,
    /// Default to this one. Because always should be a broadcaster
    this.role = ClientRole.Broadcaster,
  });

  /// Necessary to start the call
  final String channelID, token;
  final ClientRole role;
}