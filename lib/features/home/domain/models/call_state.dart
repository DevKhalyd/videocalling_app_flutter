import 'package:json_annotation/json_annotation.dart';

part 'call_state.g.dart';

/// Handle the CallState
@JsonSerializable()
class CallState {
  /// The first step to create the call is always the Requesting state.
  static const msgRequesting = 'Requesting...';

  /// Check if the other user is avaible
  static const stateRequesting = 0;

  /// Request for a call to the device. Because the user is avaible.
  static const stateCalling = 1;

  /// The call is accepted and they are on call.
  static const stateOnCall = 2;

  /// Not answared the call while the phone is ringing.
  ///
  /// This state is accepted as finalized because lost the call.
  static const stateLost = 3;

  /// The call is ended because was accepted by the other user.
  static const stateFinalized = 4;

  const CallState({required this.type});

  const CallState.requesting({this.type = stateRequesting});

  /// Useful when knows the current state of the call
  bool shouldStopRingtone() {
    switch (type) {
      case stateOnCall:
      case stateLost:
      case stateFinalized:
        return true;
      default:
        return false;
    }
  }

  /// The state of this call
  final int type;

  /// Handle the CallState for a readable human version.
  String getState() {
    switch (type) {
      case stateRequesting:
        return msgRequesting;
      case stateCalling:
        return 'Calling...';
      case stateOnCall:
        // Change for another value when is in this state
        return 'Counting time...';
      case stateLost:
        return 'Lost call';
      case stateFinalized:
        return 'Finalized';
      default:
        return 'Missing State';
    }
  }

  factory CallState.fromJson(Map<String, dynamic> json) =>
      _$CallStateFromJson(json);

  Map<String, dynamic> toJson() => _$CallStateToJson(this);
}
