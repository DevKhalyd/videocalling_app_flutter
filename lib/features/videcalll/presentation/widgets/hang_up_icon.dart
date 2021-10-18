import 'package:flutter/material.dart';

const _size = 60.0;

class HangUpIcon extends StatelessWidget {
  const HangUpIcon({
    Key? key,
    this.size = _size,
    this.onPressed,
  }) : super(key: key);

  final double size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red,
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.call_end,
              color: Colors.white,
            )),
      ),
    );
  }
}
