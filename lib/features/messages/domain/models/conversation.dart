import 'package:json_annotation/json_annotation.dart';

import 'last_message.dart';

part 'conversation.g.dart';

/// The conversation that appears in the [Chatting] screen
@JsonSerializable(explicitToJson: true)
class Conversation {
  const Conversation({
    required this.id,
    required this.idUser,
    required this.fullname,
    required this.username,
    required this.lastMessage,
    this.imgUrl,
  });

  /// Conversation's id
  final String id;

  /// Data user who is talking with
  final String idUser;
  final String fullname;
  final String username;
  final String? imgUrl;

  /// The last message to show in the [MessagesScreen]
  final LastMessage lastMessage;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
