import 'package:get/get.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/sign_in/presentation/screens/sign_in_screen.dart';
import '../../features/sign_up/presentation/screens/ask_username_screen.dart';
import '../../features/sign_up/presentation/screens/sign_up_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/videcalll/presentation/screens/videocall_screen.dart';

/// All avaible routes in the application
abstract class Routes {
  static final initial = '/';
  static final signIn = '/signIn';
  static final signUp = '/signUp';
  static final home = '/home';
  static final askUserName = '/askUserName';
  static final videocall = '/videocall';

  static final pages = <GetPage>[
    GetPage(
      name: initial,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: signIn,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: signUp,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: askUserName,
      page: () => AskUsernameScreen(),
    ),
    GetPage(
      name: videocall,
      page: () => VideocallScreen(),
    ),
  ];
}
