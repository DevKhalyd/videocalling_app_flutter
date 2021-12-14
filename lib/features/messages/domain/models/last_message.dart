import 'package:json_annotation/json_annotation.dart';

import 'message_state.dart';
import 'message_type.dart';

part 'last_message.g.dart';

/// Model that allow to show the latest messages in the [MessagesScreen]
@JsonSerializable(explicitToJson: true)
class LastMessage {
  LastMessage({
    required this.date,
    required this.messageType,
    required this.messageState,
    this.acumalativeMsgs = 0,
    this.message,
  });

  /// In backend side this a timestamp object.
  /// In the application is handle as a string
  final String date;
  final String? message;
  final int acumalativeMsgs;
  final MessageType messageType;
  final MessageState messageState;

  /// Get a message to show to the user according to the [messageType]
  String getMessage() {
    switch (messageType.type) {
      case MessageType.text:
        return message ?? '';
      case MessageType.image:
        return 'Image 📷';
      default:
        return '⁉';
    }
  }

  factory LastMessage.fromJson(Map<String, dynamic> json) =>
      _$LastMessageFromJson(json);

  Map<String, dynamic> toJson() => _$LastMessageToJson(this);
}
