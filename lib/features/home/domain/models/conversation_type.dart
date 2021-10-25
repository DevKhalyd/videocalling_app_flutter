import 'package:json_annotation/json_annotation.dart';

part 'conversation_type.g.dart';

/// Indicates what type of conversation was started
@JsonSerializable()
class ConversationType {
  static const videocall = 0;
  static const call = 1;

  const ConversationType({required this.type});

  const ConversationType.videoCallType({this.type = videocall});

  final int type;

  factory ConversationType.fromJson(Map<String, dynamic> json) =>
      _$ConversationTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationTypeToJson(this);
}
