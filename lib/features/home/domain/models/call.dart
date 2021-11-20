import 'package:json_annotation/json_annotation.dart';

import '../../../../core/shared/models/user/user.dart';
import 'call_state.dart';
import 'call_type.dart';
import 'conversation_type.dart';

part 'call.g.dart';

/// Handle the call conversation. Can be videocall and call.
/// Also handle the properties of this call and the current callState.
@JsonSerializable(explicitToJson: true)
class Call {
  Call({
    required this.date,
    required this.participantsIds,
    this.conversationType = const ConversationType.videoCallType(),
    this.callType = const CallType.outcomingType(),
    this.callState = const CallState.requesting(),
    this.duration = '',
    this.caller,
    this.receiver,
    this.channel,
    this.token,
  }) : assert(participantsIds.length == 2,
            'The correct use of this property is a length of 2 because the logic of the application.');

  /// Use to the test the call object
  Call.test({
    required this.date,
    this.participantsIds = const ['CALLER_ID', 'RECEIVER_ID'],
    this.conversationType = const ConversationType.videoCallType(),
    this.callType = const CallType.outcomingType(),
    this.callState = const CallState.requesting(),
    this.duration = '',
    this.caller,
    this.receiver,
    this.channel,
    this.token,
  }) : assert(participantsIds.length == 2,
            'The correct use of this property is a length of 2 because the logic of the application.');

  final ConversationType conversationType;
  final CallType callType;
  final CallState callState;

  /// Assing then id when makes an query
  ///
  /// To avoid to assign each time the id, create the id before to add to a collection in firestore.
  ///
  /// For future projects and new features.
  setId(String id) => _id = id;

  /// ID Call
  ///
  /// Can be empy because firestore still not generate the id.
  ///
  /// It's assigned when comes from firestore and requeried in the same query.
  @JsonKey(ignore: true)
  String _id = '';

  String get id {
    assert(_id.isNotEmpty,
        'The id is empty. Make sure that the ID is assigned when makes a request');
    return _id;
  }

  /// ID of each user envolved in this conversation.
  final List<String> participantsIds;

  /// The caller
  ///
  /// or
  ///
  /// participantsIds[0]
  final User? caller;

  /// The callee
  ///
  /// or
  ///
  /// participantsIds[1]
  final User? receiver;

  /// The time elapsed since the call start.
  ///
  /// The format is: 0 : 00
  final String duration;

  /// Call date
  final DateTime date;

  final String? channel;

  final String? token;

  @override
  String toString() {
    return 'ID: $_id \n - State: ${callState.type}';
  }

  /// Get the date for this call
  static DateTime getDateNow() => DateTime.now();

  factory Call.fromJson(Map<String, dynamic> json) => _$CallFromJson(json);

  Map<String, dynamic> toJson() => _$CallToJson(this);
}
