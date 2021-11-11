import 'package:flutter/material.dart';

class BottomAction extends StatelessWidget {
  const BottomAction({
    Key? key,
    required this.icon,
    this.onPressed,
    this.tooltip,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            tooltip: tooltip,
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: Colors.white,
            )),
      ),
    );
  }
}
