import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/bridges/fcm_bridge.dart';
import '../../../../core/enums/fcm_enums.dart';
import '../../../../core/shared/models/user/user.dart';

/// File not stored in GitHub. Just contains the AppID provided by Agora.
/// Create one with your API KEY
import '../../../../core/utils/agora_settings.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/messages.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/dialogs/info_dialog.dart';
import '../../../home/domain/models/call.dart';
import '../../../home/domain/models/call_state.dart';
import '../../../home/presentation/getX/home_controller.dart';
import '../../domain/models/video_calling_model.dart';
import '../../domain/usecases/create_call.dart';
import '../../domain/usecases/listen_call.dart';
import '../../domain/usecases/update_state_call.dart';
import '../mixin/videocall_utils.dart';

/// Handle the videocall for the caller and the receiver.
///
/// NOTE:`this` refers to the the user signed in this current session.
class VideoCallController extends GetxController with VideoCallMixin {
  static VideoCallController get to => Get.find();

  @override
  void onInit() {
    _handleArguments();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  int _durationInSeconds = 0;
  Timer? _timer;

  // NOTE: Global Functions (In this controller)
  VoidCallback get onEndCall => _onEndCall;

  /// Return to home and make a transaction
  /// to change to Finalized or Lost state
  void _onEndCall() {
    log('onEndCall called.');
    Get.back();

    /// Because the call is finalized already. We don't to do anything more.
    if (_currentCallState == CallState.stateLost ||
        _currentCallState == CallState.stateFinalized) return;
    Utils.runFunction(
      () {
        log('Updating database with new data... (Ending call...)');

        if (_callId == null) {
          Log.console(
              '_callId is null. Please verify that this values is asigned where is used',
              L.E);
          return;
        }

        final int newState;

        if (_currentCallState == CallState.stateOnCall)
          newState = CallState.stateFinalized;
        else
          newState = CallState.stateLost;
        UpdateStateCall.execute(_callId!, newState);
      },
      milliseconds: 200,
    );
  }

  // NOTE: Methods and parameters to handle the creation of the call and the handling of the call (UI)
  /// Create the call in firestore to start to listen to.
  ///
  /// Helps to manage the state of the screen
  void _createCall() async {
    if (_userToCall == null) {
      Log.console('_userToCall is null');
      return;
    }

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

    // Get the ID of this user. (The current user signed in this session)
    final idCurrentUser = HomeController.to.user?.id;

    if (idCurrentUser?.isEmpty ?? true) {
      cancelCreationCall();
      return;
    }

    // Create the call
    /// According to the logic of the application, the fist of the list is the caller and the second one is the callee
    final call = Call(
      participantsIds: [idCurrentUser!, u.id],
      date: Call.getDateNow(),
    );

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
  /// run and the screen should be updated according to the states.
  ///
  /// This method works in a different way depending on who create the call and who receive the call.
  ///
  /// If the caller made the call then the data will be updated from the [onInit] method.
  ///
  /// If the receiver wants to join to this call, then the data will be updated from the [_listenCall] method.
  ///
  /// [assignCaller] is a flag to indicate if the receiver wants to join to this call. So if it is true, then the data will be assigned from
  /// this method instead of the [onInit] method
  _listenCall(String callId, {bool assignCaller = false}) {
    Log.console('Listen call: $callId');
    final stream = ListenCall.execute(callId);

    stream.listen((call) {
      if (call == null) {
        Log.console(
            'The call is comming empty. Checking for a new update...', L.W);
        Utils.runFunction(() {
          if (call == null) {
            Log.console(
                'The call return null. So this call will be finalized.');
            _onEndCall();
          }
        });
        return;
      }

      if (assignCaller) {
        final caller = call.caller;
        if (caller == null) {
          Log.console(
              'The caller is null. Wait for new updates for the Call.', L.W);
          return;
        }

        /// Because `this` user is the receiver we want to know who is the caller and then show the user in the screen.
        _assignUserUI(caller);
      }

      /// Assign for this object
      call.setId(callId);
      _handleStateCall(call);
    });
  }

  /// The current state of the videocall
  int _currentCallState = CallState.stateRequesting;

  String? _callId;

  /// Update the UI with Call coming from the database.
  ///
  /// This method is called every time the call state changes.
  ///
  /// Use inside _listenCall method.
  void _handleStateCall(Call c) {
    final callState = c.callState.type;
    _currentCallState = callState;
    _callId = c.id;

    switch (callState) {
      case CallState.stateRequesting:
        _stateRequesting(c);
        break;
      case CallState.stateCalling:
        _stateCalling(c);
        break;
      case CallState.stateOnCall:
        _stateOnCall(c);
        break;
      case CallState.stateLost:
        _stateLost(c);
        break;
      case CallState.stateFinalized:
        _stateFinalized(c);
        break;
      default:
        assert(false, 'Missing call state');
    }
  }

  // Handlers for each state of the call

  void _stateRequesting(Call call) {
    /// This is the first state that is initializated in the init method.
    /// Nothing to do here.
    log('Requesting for the call...');
  }

  void _stateCalling(Call call) {
    log('State: Calling...');
    final callState = call.callState;
    _state = callState.getState();
    update();
    Utils.runFunction(
      () {
        if (_currentCallState == CallState.stateCalling) {
          log("Because the receiver don't answer the call. The call will be finalized...");
          _onEndCall();
        }
      },
      milliseconds: maxDurationToWait,
    );
  }

  void _stateOnCall(Call call) async {
    log('State: onCall...');
    final channel = call.channel;
    final token = call.token;

    if (channel == null || token == null) {
      final msg = """
      Channel or token is null. Finishing the call.
      Hint: Check the cloud functions in Firebase.
      Why the channel and token are null?
      """;
      Log.console(msg, L.E);
      await Get.dialog(AlertInfo(content: Messages.videocallConnectionError));
      _onEndCall();
      return;
    }

    final videoData = VideoCallingModel(
      channel: channel,
      token: token,
    );
    _prepareVideocall(videoData);
    _state = call.callState.getState();
    update();
  }

  void _stateLost(Call call) {
    log('State: onLost...');
    _state = call.callState.getState();
    update();
    Utils.runFunction(() {
      log('Ending the call...');
      _onEndCall();
    });
  }

  void _stateFinalized(Call call) {
    log('State: Finalized...');
    _state = call.callState.getState();
    update();
    _onEndCall();
  }

  /// Count the time until the users finalize the call
  void _onCountTime() {
    _timer = Timer.periodic(Duration(seconds: 1), (_timer) {
      _durationInSeconds++;
      // NOTE: Maybe this needs a unique id to update
      final time = getMinutesFromSeconds(_durationInSeconds);
      _state = time;
      update();
    });
    Log.console('Timer initializated for on call state');
  }

  /// Handle the arguments sent to the VideoScreen
  ///
  /// This serves to show some data in the application
  _handleArguments() {
    final arguments = Get.arguments;

    /// Another [User] selected by `this` user
    if (arguments is User)
      _handleUserCaller(arguments);

    /// `this` user acts as receiver
    else if (arguments is FCMBridge) {
      if (arguments.type == TypeContent.videocall)
        _handleUserReceiver(arguments.value);
      else
        assert(false, 'Missing handler arguments');
    } else
      assert(false, 'Missing handler arguments');
  }

  /// Use in the init method to prepare the screen for the user
  void _handleUserCaller(User u) {
    _assignUserUI(u);
    _createCall();
  }

  /// Assign to the UI the data of the user that is calling
  ///
  /// [u] The user who is calling to [this] current user
  ///
  /// [callState] The init state of the call
  ///
  /// [shouldUpdate] If true, the screen will be updated with the new data.
  /// Depends where this method is called to use this parameter.
  void _assignUserUI(
    User u, {
    String callState = CallState.msgRequesting,
    bool shouldUpdate = false,
  }) {
    /// Avoid to assign each time this method is called in `_listenCall`
    if (_name.isNotEmpty && _state.isNotEmpty) return;
    _userToCall = u;
    _name = u.fullname;
    _state = callState;
    if (shouldUpdate) update();
  }

  bool _isReceiver = false;

  /// Indicates to the UI what colors and icons should use the UI
  bool get isReceiver => _isReceiver;

  void _handleUserReceiver(String idVideocall) {
    _isReceiver = true;
    _listenCall(idVideocall, assignCaller: true);
  }

  /// The user to call. This is the user selected by the user.
  User? _userToCall;

  String _name = '';

  String _state = '';

  /// The name of the callee
  String get name => _name;

  /// The state of the videocall in text
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
    // TODO: If is receiver what should do this onpressed according to the state. The same with the caller

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

  /// This is the point of initialization of the videocall
  ///
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
      _videoCallingModel.channel,
      null,
      // If you set uid as 0, the system automatically assigns a uid. (From the docs)
      0,
    );
    _onCountTime();
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
