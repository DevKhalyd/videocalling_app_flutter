import 'dart:async';

import 'package:get/get.dart';

import '../../../../core/shared/models/user/user.dart';
import '../../domain/models/chat_bridge.dart';
import '../../domain/usecases/listen_user.dart';

class ChatController extends GetxController {
  late User _user;
  late String _idConversation;
  late StreamSubscription<User?> _subscription;
  User get user => _user;

  @override
  void onInit() {
    final arguments = Get.arguments;
    final condition = arguments is ChatBridge;
    if (condition) {
      final chatBridge = arguments as ChatBridge;
      _idConversation = chatBridge.idConversation;
      _user = chatBridge.user;
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
  onListenUserChanges() {
    _subscription = ListenUser.execute('').listen((user) {
      if (user != null) {
        _user = user;
        update();
      }
      update();
    });
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
