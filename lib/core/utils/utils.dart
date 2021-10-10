import 'dart:math' show Random;
import 'dart:ui';

import 'package:flutter/material.dart';

import 'logger.dart';

/// Use across of the application
abstract class Utils {
  static final _colors = <Color>[
    Colors.red,
    Colors.green,
    Colors.grey,
    Colors.orange,
    Colors.deepPurple,
    Colors.blue,
    acentColor,
  ];

  static final appName = 'Videocalling App';
  static final acentColor = Color.fromRGBO(85, 104, 254, 1.0);
  static final textFormFIeldColor = Color.fromRGBO(37, 42, 52, 1.0);

  /// ALSO SEE: kReleaseMode
  static const isDebug = true;

  static String generateId([String? suffix]) {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    return (suffix ?? 'id') + '_' + time;
  }

  static printACatch(String msg, exception) {
    Log.console(msg, L.E, exception);
  }

  static Color genereateColor() {
    final random = new Random();
    final n = random.nextInt(_colors.length - 1);
    return _colors[n];
  }
}
