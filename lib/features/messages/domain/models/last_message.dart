import 'package:json_annotation/json_annotation.dart';

import 'message_state.dart';
import 'message_type.dart';

part 'last_message.g.dart';

@JsonSerializable(explicitToJson: true)
class LastMessage {
  LastMessage({
    required this.date,
    required this.messageType,
    required this.messageState,
    this.acumalativeMessages = 0,
    this.message,
  });

  /// In backend side this a timestamp object.
  /// In the application is handle as a string
  final String date;
  final String? message;
  final int acumalativeMessages;
  final MessageType messageType;
  final MessageState messageState;

  factory LastMessage.fromJson(Map<String, dynamic> json) =>
      _$LastMessageFromJson(json);

  Map<String, dynamic> toJson() => _$LastMessageToJson(this);
}
