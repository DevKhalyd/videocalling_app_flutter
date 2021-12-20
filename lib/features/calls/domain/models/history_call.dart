import 'package:json_annotation/json_annotation.dart';

import '../../../home/domain/models/call_type.dart';
import '../../../home/domain/models/conversation_type.dart';

part 'history_call.g.dart';

/// Model to identify a call in the history
@JsonSerializable(explicitToJson: true)
class HistoryCall {
  HistoryCall({
    required this.idUser,
    required this.fullname,
    required this.username,
    required this.date,
    required this.conversationType,
    required this.callType,
    this.imgUrl,
  });

  /// The id of this user
  final String idUser;
  final String? imgUrl;
  final String fullname;
  final String username;
  final String date;
  final ConversationType conversationType;
  final CallType callType;

  // Necessary methods for this model
  factory HistoryCall.fromJson(Map<String, dynamic> json) =>
      _$HistoryCallFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryCallToJson(this);
}
