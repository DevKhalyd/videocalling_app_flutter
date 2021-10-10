import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/shared/models/user/user.dart';
import '../../../../core/utils/arguments.dart';
import '../../../../core/utils/messages.dart';
import '../../../../core/utils/routes.dart';
import '../../../../core/widgets/dialogs/info_dialog.dart';
import '../../../../core/widgets/shared/circle_profile_image.dart';
import '../../../calls/presentation/screens/calls_screen.dart';
import '../../../messages/presentation/screens/messages_screen.dart';
import '../../domain/usecases/get_email_user.dart';
import '../../domain/usecases/get_user_data.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/update_user_online.dart';
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

  /// The user information
  User? get user => _user;
  List<String> get tabs => _tabs;
  String get title => _titles[_currentPage];
  bool get isTabMessageSelected => _currentPage == 0;
  bool get isTabCallSelected => _currentPage == 1;

  @override
  void onReady() {
    assert(_pages.length == 2, 'Methods should be updated');
    super.onReady();
    _onReceiveArguments();
    _initData();
  }

  void onTabMessageSelected() => _changeCurrentPage();

  void onTabCallSelected() => _changeCurrentPage(1);

  void onVideocall() {}

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

    /// Update the app bar with the new data
    updateUser(user);
  }

  /// Get the image according to the data avaible
  Widget getImageAppbar() {
    if (user == null) return Container();

    final url = user?.imageUrl;

    if (url != null) return CircleProfileImage(url: url);

    return CircleProfileImage(firstLetter: user!.fullname[0]);
  }

  /// Update the user and notifies to the listeners
  updateUser(User u) {
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
          throw UnimplementedError("Missing string to execute");
      }
    }
  }

  /// Calleable from anywhere
  ///
  /// Sign out the current user and
  /// go to signIn page erasing the stack of screens
  signOut() {
    SignOut.execute();
    Get.offAllNamed(Routes.signIn);
  }
}
