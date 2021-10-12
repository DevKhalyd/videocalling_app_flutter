import 'package:flutter/material.dart';

const _size = 16.0;

class Dot extends StatelessWidget {
  const Dot({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: _size,
        width: _size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ));
  }
}
