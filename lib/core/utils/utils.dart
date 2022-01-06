import 'dart:async';
import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'logger.dart';

/// Use across of the application
abstract class Utils {
  static final _colors = <Color>[
    Colors.red,
    Colors.orange,
    Colors.deepPurple,
    Colors.blue,
    Colors.pink,
    acentColor
  ];
  // Assigned to your computer by router
  /// If you are in windows to get it, just:
  /// cmd > ipconfig
  static const localHost = '192.168.1.69';
  static final appName = 'Videocalling App';
  static final acentColor = Color.fromRGBO(85, 104, 254, 1.0);
  static final textFormFIeldColor = Color.fromRGBO(37, 42, 52, 1.0);
  static final bottomNavColor = Color.fromRGBO(37, 42, 52, .5);
  static final defaultProfileImg =
      'https://lacollege.edu/wp-content/uploads/2021/09/blank-profile-picture.png';

  /// Suffixes
  static final conversationSuffix = 'conversation';

  /// ALSO SEE: kReleaseMode
  static const isDebug = true;

  static String generateId([String? suffix]) {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    return (suffix ?? 'id') + '_' + time;
  }

  /// Useful when you want to print a catch from a try block
  static printACatch(String msg, exception) {
    Log.console(msg, L.E, exception);
  }

  /// Generate a random integer
  static int generateInteger() {
    return Random().nextInt(100);
  }

  static Color genereateColor() {
    final random = new Random();
    final n = random.nextInt(_colors.length - 1);
    return _colors[n];
  }

  static bool containsLetter(String letter, String input) {
    return input.contains(letter);
  }

  static void runFunction(VoidCallback callback, {int milliseconds = 750}) {
    Timer(Duration(milliseconds: milliseconds), callback);
  }

  static Future<bool> hasInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
