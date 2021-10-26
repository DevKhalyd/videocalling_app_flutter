import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videocalling_app/core/utils/logger.dart';
import 'package:videocalling_app/features/videcalll/domain/usecases/listen_call.dart';

import '../../../../core/shared/models/user/user.dart';

/// File not stored in GitHub. Just contains the AppID provided by Agora.
/// Create one with your API KEY
import '../../../../core/utils/agora_settings.dart';
import '../../../home/domain/models/call.dart';
import '../../../home/domain/models/call_state.dart';
import '../../../home/presentation/getX/home_controller.dart';
import '../../domain/models/video_calling_model.dart';
import '../../domain/usecases/create_call.dart';

class VideoCallControlller extends GetxController {
  @override
  void onInit() {
    _handleArguments();
    _createCall();
    super.onInit();
  }

  /// Create the call in firestore to start to listen to.
  ///
  /// Helps to manage the state of the screen
  void _createCall() async {
    if (_userToCall == null) return;

    /// HARD TO HAPPEN, BUT IN SOFTWARE EVERYTHING IS POSSIBLE
    final cancelCreationCall = () {
      Get.back();
      Get.snackbar(
        'Error',
        'User is not valid',
        icon: Icon(Icons.error),
        backgroundColor: Colors.red,
      );
    };

    final u = _userToCall!;

    if (!u.validate()) {
      cancelCreationCall();
      return;
    }

    // Get the ID of this user
    final idCurrentUser = HomeController.to.user?.id;

    if (idCurrentUser == null) {
      cancelCreationCall();
      return;
    }

    // Create the call
    /// According to the logic of the application, the fist of the list is the caller and the second one is the callee
    final call = Call(participantsIds: [idCurrentUser, u.id]);

    final reference = await CreateCall.execute(call);

    if (reference == null) {
      cancelCreationCall();
      return;
    }

    // Liisten to this object to get the state of the call
    final idDocument = reference.id;

    _listenCall(idDocument);
  }

  /// If this method is called means that the call started to
  /// run and the screen should be updated according to the states
  _listenCall(String callId) {
    final stream = ListenCall.execute(callId);

    stream.listen((event) {
      if (event == null) {
        Log.console(
            'The call is comming empty. This shouldn"t  happen because the document was created already.',
            L.E);
        return;
      }
      // TODO: Change the states of the screen
    });
  }

  /// Handle the arguments sent to the VideoScreen
  ///
  /// This serves to show some data in the application
  _handleArguments() {
    final arguments = Get.arguments;

    if (arguments is User) {
      _assingScreenData(arguments);
    } else
      assert(false, 'Missing argument case');
  }

  /// Use in the init method to prepare the screen for the user
  _assingScreenData(User u) {
    _userToCall = u;
    _name = u.fullname;
    _state = CallState.msgRequesting;
  }

  /// The user to call. This is the user selected by the user.
  User? _userToCall;

  String _name = '';

  String _state = '';

  /// The name of the callee
  String get name => _name;

  /// The state of the videocall
  ///
  /// Like: requesting,waiting, oncall (Start to count  each second and convert to minutes)
  String get state => _state;

  void onPressCamerasSwitch() {}

  void onPressMicroPhone() {
    /*_muted = !_muted;
    _engine.muteLocalAudioStream(_muted);
    update(['muted']);*/
  }

  Function? onPressHangUp() {
    if (_state == CallState.msgRequesting) return null;
    return () {
      print('Hang up');
    };
  }

  //NOTE: Agora Engine

  // The id of each user assigned by Agora Engine
  final users = <int>[];

  /// Views to show in the screen of each user
  List<Widget> views = <Widget>[];

  // NOTE: Those `late` values will be initializated when the videocall is accepted by the other user

  /// This model is received through the arguments
  late VideoCallingModel _videoCallingModel;

  /// The _engine to start the videocall
  late RtcEngine _engine;
  // Handle the UI
  bool _muted = false, _defaultView = true;

  bool get muted => _muted;

  /// The default view is when `this` user is a mini player
  /// and the other one is in a bigger player.
  ///
  /// So, put this one in false means the opposite.
  bool get defaultView => _defaultView;

  // TODO: If there is a response from the FCM that the notification was sent.  So call this method
  /// [data] from the Cloud Functions
  void _prepareVideocall(VideoCallingModel data) {
    _videoCallingModel = data;
    _initAgoraRtcEngine();
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(AgoraSettings.appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(_videoCallingModel.role);

    _agoraEventHandlers();

    // Don´t need it
    // VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    // configuration.dimensions = VideoDimensions(1920, 1080);
    // await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(
      _videoCallingModel.token,
      _videoCallingModel.channelID,
      null,
      // If you set uid as 0, the system automatically assigns a uid. (From the docs)
      0,
    );
  }

  void _agoraEventHandlers() => _engine.setEventHandler(
        RtcEngineEventHandler(
          error: (code) => log('Something bad happens. Code: $code'),
          joinChannelSuccess: (channel, uid, elapsed) =>
              log('onJoinChannel: $channel, uid: $uid elapsed: $elapsed'),
          leaveChannel: (stats) {
            users.clear();
            _assignViews();
          },
          userJoined: (uid, elapsed) {
            users.add(uid);
            _assignViews();
          },
          userOffline: (uid, elapsed) {
            users.remove(uid);
            _assignViews();
          },
        ),
      );

  void _assignViews() {
    views = _getRenderViews();
    update();
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (_videoCallingModel.role == ClientRole.Broadcaster)
      list.add(rtc_local_view.SurfaceView());

    users.forEach((int uid) => list.add(rtc_remote_view.SurfaceView(uid: uid)));
    return list;
  }

  /// Turn on and turn off the video
  void onToggleMute() {
    _muted = !_muted;
    _engine.muteLocalAudioStream(_muted);
    update();
  }

  /// Switch the camera between the front and the back
  void onSwitchCamera() => _engine.switchCamera();

  /// Get the camera from the back to the fronted
  void onChangeViews() {
    _defaultView = !_defaultView;
    update();
  }
}
