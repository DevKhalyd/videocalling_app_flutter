import 'dart:async';

import 'package:get/get.dart';
import 'package:videocalling_app/features/chat/domain/usecases/listen_user.dart';

import '../../../../core/shared/models/user/user.dart';

class ChatController extends GetxController {
  late User _user;
  late StreamSubscription<User?> _subscription;
  User get user => _user;

  @override
  void onInit() {
    final arguments = Get.arguments;
    if (arguments is User)
      _user = arguments;
    else
      assert(false, 'Arguments must be a User');
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
