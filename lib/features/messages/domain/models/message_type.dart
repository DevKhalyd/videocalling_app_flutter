import 'package:json_annotation/json_annotation.dart';

part 'message_type.g.dart';

@JsonSerializable()
class MessageType {
  static const text = 0;
  static const image = 1;

  const MessageType({required this.type});

  const MessageType.textType() : this(type: text);

  const MessageType.imageType() : this(type: image);

  final int type;

  factory MessageType.fromJson(Map<String, dynamic> json) =>
      _$MessageTypeFromJson(json);

  Map<String, dynamic> toJson() => _$MessageTypeToJson(this);
}
