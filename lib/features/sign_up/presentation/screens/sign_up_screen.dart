import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/mini_widgets.dart';
import '../../../../core/widgets/shared/txt_form_field_custom.dart';
import '../getX/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (c) {
          return ScaffoldForm(
            backgroundColor: Colors.black,
            children: [
              Space(0.09),
              HeaderForms(
                title: 'Create new account',
                description: 'Please fill in the form to continue',
              ),
              Space(0.05),
              TextFormFieldCustom(
                hintText: 'Full Name',
                keyboardType: TextInputType.name,
              ),
              TextFormFieldCustom(
                hintText: 'E-mail Address',
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormFieldCustom(
                hintText: 'Password',
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              Space(0.05),
              FormButton(
                label: 'Sign Up',
              ),
              Space(0.06),
              RichTextCustom(
                firstText: 'Have an Account?',
                secondText: 'Sign In',
                onPressed: c.onSignInUser,
              )
            ],
          );
        });
  }
}
