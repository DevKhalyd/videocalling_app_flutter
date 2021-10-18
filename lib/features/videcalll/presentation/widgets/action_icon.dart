import 'package:flutter/material.dart';

const _sizeContainer = 80.0;

/// The icon to show in the videocall screen. For example, Record, Add, Speaker
class ActionIcon extends StatelessWidget {
  const ActionIcon({
    Key? key,
    required this.icon,
    this.isEnabled = false,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    // TODO: Add the material part to the icon if needed
    return Container(
      height: _sizeContainer,
      width: _sizeContainer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color:
            isEnabled ? Colors.deepPurple : Colors.deepPurple.withOpacity(0.3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
