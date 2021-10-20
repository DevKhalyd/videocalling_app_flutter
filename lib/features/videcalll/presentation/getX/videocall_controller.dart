import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:videocalling_app/features/videcalll/domain/models/video_calling_model.dart';

/// File not stored in GitHub. Just contains the APPID provided by Agora
import '../../../../core/utils/agora_settings.dart';

class VideoCallControlller extends GetxController {
  // The id of each user (?)
  final users = <int>[];

  /// Views to show in the screen of each user
  List<Widget> views = <Widget>[];

  /// This model is received through the arguments
  late VideoCallingModel _videoCallingModel;

  /// The _engine to start the videocall
  late RtcEngine _engine;
  // Handle the UI
  bool _muted = false, _defaultView = true;

  bool get mute => _muted;

  @override
  void onInit() {
    final data = Get.arguments as VideoCallingModel;
    if (data is! VideoCallingModel) {
      assert(false, 'Missing VideoCallingModel');
      return;
    }
    _videoCallingModel = data;

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  

  Future<void> _initAgoraRtcEngine() async {
    // ignore: deprecated_member_use
    _engine = await RtcEngine.create(AgoraSettings.appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(_videoCallingModel.role);

    //_agoraEventHandlers();

    // Don´t needed
    // VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    // configuration.dimensions = VideoDimensions(1920, 1080);
    //await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(
      _videoCallingModel.token,
      _videoCallingModel.channelID,
      null,
      // If you set uid as 0, the system automatically assigns a uid. (From the docs)
      0,
    );
  }
}
