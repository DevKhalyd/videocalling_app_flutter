import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  Size get size => MediaQuery.of(this).size;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  double get width => size.width;
  double get height => size.height;
  double get paddingTop => padding.top;
}
