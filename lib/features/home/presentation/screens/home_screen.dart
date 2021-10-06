import 'package:flutter/material.dart';

import '../../../../core/widgets/mini_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CenterText('Center Data and custom this one'),
    );
  }
}
