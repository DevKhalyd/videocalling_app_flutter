import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/repositories/fcm_repository.dart';
import '../../../../core/shared/models/user/user.dart';
import '../../../../core/utils/arguments.dart';
import '../../../../core/utils/messages.dart';
import '../../../../core/utils/routes.dart';
import '../../../../core/widgets/dialogs/alert_option.dart';
import '../../../../core/widgets/dialogs/info_dialog.dart';
import '../../../../core/widgets/shared/circle_profile_image.dart';
import '../../../calls/presentation/screens/calls_screen.dart';
import '../../../messages/presentation/screens/messages_screen.dart';
import '../../../sign_up/domain/usecases/get_fcm_token.dart';
import '../../domain/usecases/get_email_user.dart';
import '../../domain/usecases/get_user_data.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/update_fcm_token.dart';
import '../../domain/usecases/update_user_online.dart';
import '../screens/home_searcher_screen.dart';
import '../screens/image_picker_screen.dart';

/// Handle each fragment in this screen
class HomeController extends GetxController {
  /// Allow to update
  static const idUnique = 'id';
  static HomeController get to => Get.find();

  /// Pages to show
  final _pages = [
    MessagesScreen(),
    CallsScreen(),
  ];

  /// The app bar titles
  final _titles = <String>[
    'Chatting',
    'Calls',
  ];

  /// The bottom names.
  final _tabs = [
    'Messages',
    'Calls',
  ];

  int _currentPage = 0;
  User? _user;

  Widget get currentPage => _pages[_currentPage];

  /// The user information of the current user signed in the application
  User? get user => _user;
  List<String> get tabs => _tabs;
  String get title => _titles[_currentPage];
  bool get isTabMessageSelected => _currentPage == 0;
  bool get isTabCallSelected => _currentPage == 1;

  @override
  void onReady() {
    assert(_pages.length == 2, 'Methods should be updated');
    super.onReady();
    FCMRepository.onMessage();
    _onReceiveArguments();
    _initData();
  }

  void onTabMessageSelected() => _changeCurrentPage();

  void onTabCallSelected() => _changeCurrentPage(1);

  /// When press the videocall button
  void onVideocall() => Get.to(() => HomeSearcherScreen());

  void _changeCurrentPage([int value = 0]) {
    if (value == _currentPage) return;
    _currentPage = value;
    update([idUnique]);
  }

  /// Update the UI with the user data
  void _initData() async {
    final _signOut = () async {
      await Get.dialog(AlertInfo(content: Messages.signInAgain));
      signOut();
    };

    final email = GetEmailUser.execute();

    if (email == null) {
      _signOut();
      return;
    }

    //  Make the request to get the latest information and update the UI
    final user = await GetUserData.execute(email);

    if (user == null) {
      _signOut();
      return;
    }

    if (!user.isOnline) {
      //Update the user status to online : true
      if (user.validate())
        UpdateUserOnlineStatus.execute(id: user.id, isOnline: true);
    }

    updateUser(user);
    onUpdateFCMToken();
  }

  /// Update the FCM of this user after the data is fetched.
  onUpdateFCMToken() async {
    final u = user!;

    /// The current token
    final currentToken = await GetFCMToken.execute();

    /// Update token in firestore
    if (u.tokenFCM != currentToken)
      UpdateFCMToken.execute(id: u.id, token: currentToken);
  }

  /// Get the image according to the data avaible
  Widget getImageAppbar() {
    if (user == null) return Container();

    final url = user?.imageUrl;
    final firstLetter = user?.fullname[0];

    return GestureDetector(
        onTap: _onSignOut,
        child: CircleProfileImage(url: url, firstLetter: firstLetter));
  }

  /// Update the user and notifies to the listeners. ( Update the app bar with the new data)
  void updateUser(User u) {
    _user = u;
    update();
  }

  /// Do something if receive some arguments
  void _onReceiveArguments() {
    final arguments = Get.arguments;
    if (arguments is String) {
      switch (arguments) {
        case Arguments.openImagePicker:
          Get.to(ImagePickerScreen());
          break;
        default:
          throw UnimplementedError("Missing argument to execute");
      }
    }
  }

  /// Calleable from anywhere
  ///
  /// Sign out the current user and
  /// go to signIn page erasing the stack of screens
  void signOut() {
    SignOut.execute();
    Get.offAllNamed(Routes.signIn);
  }

  // End this one
  void _onSignOut() async {
    final result = await Get.dialog(
        AlertOption(content: 'Do you want to sign out of the app?'));
    if (result is bool) {
      if (result) signOut();
    }
  }
}
