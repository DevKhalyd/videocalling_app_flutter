import 'package:flutter/material.dart';

import '../../../../core/widgets/mini_widgets.dart';

// TODO: Set the option to upload an image to the server.
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CenterText('Center Data and custom this one'),
    );
  }
}
