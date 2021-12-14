import 'package:json_annotation/json_annotation.dart';

part 'message_state.g.dart';

@JsonSerializable()
class MessageState {
  static const sent = 0;
  static const delivered = 1;
  static const seen = 2;

  const MessageState({required this.type});
  final int type;

  factory MessageState.fromJson(Map<String, dynamic> json) =>
      _$MessageStateFromJson(json);

  Map<String, dynamic> toJson() => _$MessageStateToJson(this);
}
