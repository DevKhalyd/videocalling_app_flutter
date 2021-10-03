import 'package:get/get.dart';

import '../features/sign_in/presentation/screens/sign_in_screen.dart';
import '../features/sign_up/presentation/screens/sign_up_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';

/// All avaible routes in the application
abstract class Routes {
  static final initial = '/';
  static final signIn = '/signIn';
  static final signUp = '/signUp';

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
  ];
}
