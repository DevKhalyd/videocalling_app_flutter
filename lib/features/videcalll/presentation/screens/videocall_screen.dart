import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';
import '../widgets/videocall_bottom_container.dart';

class VideocallScreen extends StatelessWidget {
  const VideocallScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.textFormFIeldColor,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: BackButton(color: Colors.white),
            ),
            // Use a stakc
            // The video screen
            Spacer(),
            // Options
            // Bottom bar
            VideoCallBottomContainer()
          ],
        ),
      ),
    );
  }
}
