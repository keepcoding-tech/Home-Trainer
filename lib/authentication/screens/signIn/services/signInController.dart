import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:home_trainer/authentication/screens/signIn/utilities/signInInteractiveTexts.dart';
import 'package:home_trainer/authentication/services/authenticationController.dart';
import 'package:home_trainer/authentication/screens/signIn/utilities/signInButtons.dart';
import 'package:home_trainer/authentication/screens/signIn/utilities/signInForm.dart';
import 'package:home_trainer/authentication/utilities/validation.dart';

class SignInController extends StatelessWidget {
  final SignInTexts _signInTexts = new SignInTexts();

  final SignInForm _emailForm = new SignInForm(
    labelText: 'email',
    inputType: TextInputType.emailAddress,
    obscureText: false,
    validator: Validation().emailValidator(),
  );

  final SignInForm _passwordForm = new SignInForm(
    labelText: 'password',
    inputType: TextInputType.text,
    obscureText: true,
    validator: Validation().passwordValidator(),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // email textTormField
        _emailForm.build(context),
        // password textTormField
        _passwordForm.build(context),
        // forgot password text
        _signInTexts.forgotPassword(context),
        SizedBox(height: 10.0),
        // sign in with email and password
        SignInButtons(
          buttonText: 'LOGIN',
          buttonColor: Colors.white,
          textColor: Colors.black,
          onPressed: () {
            if (_emailForm.formKey.currentState.validate() &&
                _passwordForm.formKey.currentState.validate()) {
              // Login to the account
              context.read<AuthenticationController>().signIn(
                    email: _emailForm.controller.text.trim(),
                    password: _passwordForm.controller.text.trim(),
                    context: context,
                  );
            }
          },
        ),
        // sign in with facebook
        SignInButtons(
            buttonText: 'Facebook',
            buttonColor: Colors.blue.shade800,
            textColor: Colors.white,
            onPressed: () {
              context
                  .read<AuthenticationController>()
                  .signInWithFacebook(context);
            }),
        // sign in with google
        SignInButtons(
          buttonText: 'Google',
          buttonColor: Colors.red.shade800,
          textColor: Colors.white,
          onPressed: () {
            context.read<AuthenticationController>().signInWithGoogle();
          },
        ),
        SizedBox(height: 10.0),
        // go to registration page
        _signInTexts.dontHaveAccountText(context),
      ],
    );
  }
}
