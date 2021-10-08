import 'package:flutter/material.dart';

import '../../../../core/widgets/mini_widgets.dart';

class MessagesScreen extends StatelessWidget {
  /// Show the current messages for this user
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CenterText('Messages Screens'),
    );
  }
}
