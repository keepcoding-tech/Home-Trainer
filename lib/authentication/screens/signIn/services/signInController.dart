import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:home_trainer/authentication/screens/signIn/utilities/signInTexts.dart';
import 'package:home_trainer/authentication/services/authenticationController.dart';
import 'package:home_trainer/authentication/screens/signIn/utilities/signInButtons.dart';
import 'package:home_trainer/authentication/screens/signIn/utilities/signInTextFormFields.dart';
import 'package:home_trainer/authentication/utilities/validation.dart';

class SignInController extends StatelessWidget {
  final SignInTexts _signInTexts = new SignInTexts();

  final SignInTextFormFields _emailForm = new SignInTextFormFields(
    labelText: 'email',
    inputType: TextInputType.emailAddress,
    obscureText: false,
    validator: Validation().emailValidator(),
  );

  final SignInTextFormFields _passwordForm = new SignInTextFormFields(
    labelText: 'password',
    inputType: TextInputType.text,
    obscureText: true,
    validator: Validation().passwordValidator(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          // sign in title
          _signInTexts.signInTitle(),
          // email textTormField
          _emailForm.build(context),
          // password textTormField
          _passwordForm.build(context),
          // forgot password text
          _signInTexts.forgotPassword(context),
          SizedBox(height: 10.0),
          // sign in with email and password
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: LoginButton(
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
          ),
          SizedBox(
            height: 40,
            child: Center(
              child: Text(
                '- OR -',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // sign in with facebook
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SocialMediaLogin(
                icon: FontAwesomeIcons.facebook,
                buttonColor: Color(0xFF1773EA),
                onPressed: () {
                  context
                      .read<AuthenticationController>()
                      .signInWithFacebook(context);
                },
              ),
              // sign in with google
              SocialMediaLogin(
                icon: FontAwesomeIcons.google,
                buttonColor: Color(0xFFDD3D2B),
                onPressed: () {
                  context.read<AuthenticationController>().signInWithGoogle();
                },
              ),
            ],
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
