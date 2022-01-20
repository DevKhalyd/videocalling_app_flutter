import 'package:json_annotation/json_annotation.dart';

import '../../../messages/domain/models/message_state.dart';
import '../../../messages/domain/models/message_type.dart';

part 'message.g.dart';

/// The message in a conversation.
@JsonSerializable(explicitToJson: true)
class Message {
  const Message({
    required this.idUser,
    this.date = '',
    required this.data,
    required this.messageType,
    required this.messageState,
  });

  /// The id of the user who sent the message.
  final String idUser;

  /// The server assigns the date
  final String date;

  /// The data works in different ways depending on
  /// the type of the message
  final String data;
  final MessageType messageType;
  final MessageState messageState;

  String getReadableDate() {
    return 'GET IT';
  }

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
