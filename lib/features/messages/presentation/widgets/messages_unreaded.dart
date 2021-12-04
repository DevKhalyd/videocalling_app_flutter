import 'package:flutter/material.dart';
import 'package:videocalling_app/core/utils/utils.dart';
import 'package:videocalling_app/core/widgets/mini_widgets.dart';

class MessagesUnreaded extends StatelessWidget {
  const MessagesUnreaded({
    Key? key,
    required this.unreaded,
  })  : assert(unreaded > 0, 'Ensure that unreaded is greater than 0'),
        super(key: key);

  final int unreaded;

  @override
  Widget build(BuildContext context) {
    return _CircularBackground(
      text: unreaded.toString(),
    );
  }
}

const _size = 20.0;

class _CircularBackground extends StatelessWidget {
  const _CircularBackground({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _size,
      width: _size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Utils.acentColor,
      ),
      child: CenterText(
        text,
        color: Colors.white,
      ),
    );
  }
}
