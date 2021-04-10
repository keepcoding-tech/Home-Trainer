import 'package:flutter/material.dart';
import 'package:home_trainer/authentication/screens/createUserInfo/createUserInfoPage.dart';

import 'package:home_trainer/authentication/screens/signUp/utilities/termsAndConditions.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/createAccountButton.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/signUpTextFormFields.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/signUpTexts.dart';
import 'package:home_trainer/authentication/utilities/validation.dart';

class SignUpController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TermsAndConditions _termsAndConditions = new TermsAndConditions();
    final SignUpTexts _signUpTexts = new SignUpTexts();

    final SignUpTextFormFields _emailForm = new SignUpTextFormFields(
      labelText: 'email',
      inputType: TextInputType.emailAddress,
      obscureText: false,
      validator: Validation().createAccountEmailValidator(context),
    );

    final SignUpTextFormFields _passwordForm = new SignUpTextFormFields(
      labelText: 'password',
      inputType: TextInputType.text,
      obscureText: true,
      validator: Validation().passwordValidator(),
    );

    final SignUpTextFormFields _confirmPasswordForm = new SignUpTextFormFields(
      labelText: 'confirm password',
      inputType: TextInputType.text,
      obscureText: true,
      validator: (value) {
        if (value != _passwordForm.controller.text) {
          return 'The passwords doesn\'t mach';
        }
        return null;
      },
    );

    return Container(
      margin: EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          // sign up title
          _signUpTexts.signUpTitle(),
          // email textTormField
          _emailForm,
          // password textTormField
          _passwordForm,
          // confirm password textTormField
          _confirmPasswordForm,
          // agree to terms and conditions
          _termsAndConditions,
          // create account button
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: CreateAccountButton(
              onPressed: () async {
                if (_emailForm.formKey.currentState.validate()) {
                  if (_passwordForm.formKey.currentState.validate()) {
                    if (_confirmPasswordForm.formKey.currentState.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateUserInfoPage(
                            email: _emailForm.controller.text.trim(),
                            password: _passwordForm.controller.text.trim(),
                            authMethod: 'email & password',
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    }
                  }
                }
              },
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
