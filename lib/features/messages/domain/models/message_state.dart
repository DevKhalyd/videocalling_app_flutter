import 'package:json_annotation/json_annotation.dart';

part 'message_state.g.dart';

@JsonSerializable()
class MessageState {
  static const sent = 0;
  static const delivered = 1;
  static const seen = 2;

  const MessageState({required this.type});

  const MessageState.deliveredState() : this(type: delivered);

  const MessageState.sentState() : this(type: sent);

  const MessageState.seenState() : this(type: seen);

  final int type;

  factory MessageState.fromJson(Map<String, dynamic> json) =>
      _$MessageStateFromJson(json);

  Map<String, dynamic> toJson() => _$MessageStateToJson(this);
}
