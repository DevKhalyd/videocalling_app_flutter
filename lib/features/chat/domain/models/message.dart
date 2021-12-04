import 'package:json_annotation/json_annotation.dart';

import '../../../messages/domain/models/message_type.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
class Message {
  const Message({
    required this.idUser,
    required this.date,
    required this.data,
    required this.type,
  });

  final String idUser;
  final String date;

  /// The data works in different ways depending on
  /// the type of the message
  final String data;
  final MessageType type;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
