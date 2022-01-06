import 'package:json_annotation/json_annotation.dart';

part 'message_type.g.dart';

@JsonSerializable()
class MessageType {
  static const initialMessage = -1;
  static const text = 0;
  static const image = 1;

  const MessageType({required this.type});

  const MessageType.textType() : this(type: text);

  const MessageType.imageType() : this(type: image);

  const MessageType.initialMessageType() : this(type: initialMessage);

  final int type;

  factory MessageType.fromJson(Map<String, dynamic> json) =>
      _$MessageTypeFromJson(json);

  Map<String, dynamic> toJson() => _$MessageTypeToJson(this);
}
