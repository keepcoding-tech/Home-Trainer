import 'package:flutter/material.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/emailVerificationMessage.dart';
import 'package:provider/provider.dart';

import 'package:home_trainer/authentication/screens/signUp/utilities/termsAndConditions.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/createAccountButton.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/signUpTextFormFields.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/signUpTexts.dart';
import 'package:home_trainer/authentication/services/authenticationController.dart';
import 'package:home_trainer/authentication/utilities/validation.dart';

class SignUpController extends StatelessWidget {
  final TermsAndConditions _termsAndConditions = new TermsAndConditions();
  final SignUpTexts _signUpTexts = new SignUpTexts();

  @override
  Widget build(BuildContext context) {
    final SignUpTextFormFields _nameForm = new SignUpTextFormFields(
      labelText: 'name',
      inputType: TextInputType.text,
      obscureText: false,
      validator: Validation().nameValidator(),
    );

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
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          // sign up title
          _signUpTexts.signUpTitle(),
          // name text form field
          _nameForm,
          // email text form field
          _emailForm,
          // password text form field
          _passwordForm,
          // confirm password text form field
          _confirmPasswordForm,
          // agree to terms and conditions
          _termsAndConditions,
          // create account button
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: CreateAccountButton(
              onPressed: () async {
                if (_nameForm.formKey.currentState.validate()) {
                  if (_emailForm.formKey.currentState.validate()) {
                    if (_passwordForm.formKey.currentState.validate()) {
                      if (_confirmPasswordForm.formKey.currentState
                          .validate()) {
                        context
                            .read<AuthenticationController>()
                            .signUp(
                              name: _nameForm.controller.text.trim(),
                              email: _emailForm.controller.text.trim(),
                              password: _passwordForm.controller.text.trim(),
                            )
                            .then(
                          (value) {
                            Navigator.pop(context);

                            showEmailVerificationMessage(
                              context,
                              _emailForm.controller.text.trim(),
                            );
                          },
                        );
                      }
                    }
                  }
                }
              },
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
