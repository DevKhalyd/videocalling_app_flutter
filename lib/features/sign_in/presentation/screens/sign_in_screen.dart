import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../core/widgets/mini_widgets.dart';
import '../../../../core/widgets/shared/txt_form_field_custom.dart';
import '../getX/sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
      init: SignInController(),
      builder: (c) {
        return ScaffoldForm(
          formKey: c.formKey,
          backgroundColor: Colors.black,
          children: [
            Space(0.09),
            HeaderForms(
              title: 'Welcome Back!',
              description: 'Please sign in to your account',
            ),
            Space(0.09),
            TextFormFieldCustom(
              hintText: 'E-mail',
              keyboardType: TextInputType.emailAddress,
              validator: c.onValidatorEmail,
              onSaved: c.onSaveEmail,
            ),
            TextFormFieldCustom(
              hintText: 'Password',
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
              validator: c.onValidatorPassword,
              onSaved: c.onSavePassword,
            ),
            Space(0.09),
            FormButton(
              label: 'Sign In',
              onPressed: c.onSignIn,
            ),
            Space(0.06),
            RichTextCustom(
              firstText: "Don't have an Account?",
              secondText: 'Sign Up',
              onPressed: c.onSignUpUser,
            )
          ],
        );
      },
    );
  }
}
