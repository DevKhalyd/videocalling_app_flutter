import 'package:videocalling_app/core/shared/models/user/user.dart';

class ChatBridge {
  const ChatBridge({
    required this.idConversation,
    required this.user,
  });

  /// The conversation's id to start to listen
  final String idConversation;

  /// Basic information about the user to talk with
  final User user;
}
