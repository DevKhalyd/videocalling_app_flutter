import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/mini_widgets.dart';
import '../../../../core/widgets/shared/txt_form_field_custom.dart';
import '../getX/ask_username_controller.dart';

/// Part of the SignUpScreen. This screen just ask for the username of this user
/// and then sign up with the data entered previously.
class AskUsernameScreen extends StatelessWidget {
  const AskUsernameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AskUsernameController>(
      init: AskUsernameController(),
      builder: (c) {
        final isLoading = c.isLoading;
        return ScaffoldForm(
          backgroundColor: Colors.black,
          children: [
            TextCustom(
              'Introduce your username to use in the application',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            Space(0.01),
            TextFormFieldCustom(
              hintText: 'Username',
              controller: c.controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              suffixIcon: c.isLookingUp ? CircularProgressCustom() : null,
              validator: c.onValidation,
            ),
            Space(0.05),
            if (isLoading) CircularProgressCustom(),
            if (!isLoading)
              FormButton(
                label: 'Sign Up',
                isEnabled: c.isEnabled,
                onPressed: c.signUp,
              )
          ],
        );
      },
    );
  }
}
