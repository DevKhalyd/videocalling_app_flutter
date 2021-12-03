import 'package:flutter/material.dart';
import 'package:videocalling_app/core/utils/utils.dart';

import '../../../../core/widgets/mini_widgets.dart';

/// Just show the current messages for this user
///
/// Check the chat feature to see the messages in each chat
class MessagesScreen extends StatelessWidget {
  /// Show the current messages for this user
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.textFormFIeldColor,
      body: CenterText(
        'Messages Screens',
        color: Colors.white,
      ),
    );
  }
}
