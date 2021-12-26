import 'dart:async';

import 'package:get/get.dart';
import 'package:videocalling_app/features/home/presentation/getX/home_controller.dart';

import '../../../../core/shared/models/user/user.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/models/chat_bridge.dart';
import '../../domain/models/message.dart';
import '../../domain/usecases/listen_conversation.dart';
import '../../domain/usecases/listen_user.dart';

class ChatController extends GetxController {
  late User _user;
  late String _idConversation;

  /// Listen to the user changes in the database. This the User who is talking with.
  late StreamSubscription<User?> _userSubscription;
  late Stream<List<Message>> _messagesStream;

  /// The user who is talking with.
  User get user => _user;

  String _idThisUser = HomeController.to.idUser;

  /// Messages to show in the screen
  Stream<List<Message>> get messages => _messagesStream;

  @override
  void onInit() {
    final arguments = Get.arguments;
    final condition = arguments is ChatBridge;
    if (condition) {
      final chatBridge = arguments as ChatBridge;
      _idConversation = chatBridge.idConversation;
      _user = chatBridge.user;
      if (_idConversation.isEmpty) {
        Log.console(
            'IdConversation is empty. Cannot listen to the new documents', L.E);
        return;
      }
      _messagesStream = ListenConversation.execute(_idConversation);
    } else
      assert(condition);
    super.onInit();
  }

  @override
  void onReady() {
    onListenUserChanges();
    super.onReady();
  }

  /// Do changes according to the state of the user in firebase
  void onListenUserChanges() {
    final idUser = _user.id;

    /// This case don't have to happen because always must receive the user id
    if (idUser.isEmpty) {
      Log.console(
          'The idUser is empty. Send it in the ChatBridge inside of the User object',
          L.E);
      return;
    }

    _userSubscription = ListenUser.execute(idUser).listen((u) {
      if (u == null) return;
      Log.console('New data of this user was received $u');
      _user = u;
      update();
    });
  }

  @override
  void onClose() {
    _userSubscription.cancel();
    super.onClose();
  }

  onSendMessage() {
    Log.console('Send message');
  }
}
