import 'package:flutter/material.dart';

import '../../../../core/widgets/mini_widgets.dart';

class CallsScreen extends StatelessWidget {
  /// Show the history of the calls for this user
  const CallsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CenterText('Calls Screens'),
    );
  }
}
