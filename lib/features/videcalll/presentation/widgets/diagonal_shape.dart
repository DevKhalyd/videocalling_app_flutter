import 'dart:math' as math;
import 'package:flutter/material.dart';

class DiagonalShape extends StatelessWidget {
  const DiagonalShape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(angle: -math.pi / -4, child: _Shape());
  }
}

class _Shape extends StatelessWidget {
  const _Shape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: 40,
      color: Colors.red,
    );
  }
}
