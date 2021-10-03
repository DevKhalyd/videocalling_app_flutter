import 'package:flutter/material.dart';
import 'package:videocalling_app/core/widgets/shared/txt_form_field_custom.dart';

import '../../../../core/widgets/mini_widgets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // Check if this can be rewrite to avoid this safearea
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Space(0.09),
              HeaderForms(
                title: 'Welcome Back!',
                description: 'Please sign in to your account',
              ),
              Space(0.09),
              TextFormFieldCustom(hintText: 'E-mail'),
              TextFormFieldCustom(
                hintText: 'Password',
                isPassword: true,
              ),
              Space(0.09),
              FormButton(
                label: 'Sign In',
              ),
              Space(0.06),
              RichTextCustom(
                firstText: "Don't have an Account?",
                secondText: 'Sign Up',
              )
            ],
          ),
        ),
      ),
    );
  }
}
