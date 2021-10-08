import 'package:flutter/services.dart';

// IMPROVE: Change the colors
abstract class MyThemes {
  static const SystemUiOverlayStyle lightTheme = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  static const SystemUiOverlayStyle primaryTheme = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
