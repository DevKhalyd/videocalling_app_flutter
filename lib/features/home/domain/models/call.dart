import 'package:json_annotation/json_annotation.dart';

import '../../../../core/shared/models/user/user.dart';
import 'call_state.dart';
import 'call_type.dart';
import 'conversation_type.dart';

part 'call.g.dart';

/// Handle the call conversation. Can be videocall and call.
/// Also handle the properties of this call and the current state.
@JsonSerializable()
class Call {
  Call({
    required this.participantsIds,
    this.conversationType = const ConversationType.videoCallType(),
    this.callType = const CallType.outcomingType(),
    this.state = const CallState.requesting(),
    this.durationInSeconds = 0,
    this.participantA,
    this.participantB,
  }) : assert(participantsIds.length == 2,
            'The correct use of this property is a length of 2 because the logic of the application.');

  final ConversationType conversationType;
  final CallType callType;
  final CallState state;

  /// Assing then id when makes an query
  ///
  /// To avoid to assign each time the id, create the id before to add to a collection in firestore
  setId(String id) => _id = id;

  /// ID Call
  ///
  /// Can be empy because firestore still not generate the id.
  ///
  /// It's assigned when comes from firestore and requeried in the same query.
  @JsonKey(ignore: true)
  String _id = '';

  String get id {
    assert(id.isNotEmpty,
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
  final User? participantA;

  /// The callee
  ///
  /// or
  ///
  /// participantsIds[1]
  final User? participantB;

  /// The time elapsed since the call start.
  final int durationInSeconds;

  factory Call.fromJson(Map<String, dynamic> json) => _$CallFromJson(json);

  Map<String, dynamic> toJson() => _$CallToJson(this);
}
