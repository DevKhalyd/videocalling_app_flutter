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
          useScroll: false,
          children: [
            Space(0.05),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: TextCustom(
                  'Introduce your username to use it \nin the app',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Space(0.03),
            TextFormFieldCustom(
              hintText: 'Username',
              controller: c.controller,
              focusNode: c.focusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              suffixIcon: c.isLookingUp ? CircularProgressCustom() : null,
              validator: c.onValidation,
            ),
            Expanded(
                child: Center(
              child: !isLoading
                  ? FormButton(
                      label: 'Sign Up',
                      isEnabled: c.isEnabled,
                      onPressed: c.signUp,
                    )
                  : CircularProgressCustom(),
            )),
          ],
        );
      },
    );
  }
}
