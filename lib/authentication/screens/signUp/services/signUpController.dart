import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:home_trainer/authentication/services/authenticationController.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/emailVerificationMessage.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/termsAndConditions.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/createAccountButton.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/signUpForm.dart';
import 'package:home_trainer/authentication/utilities/validation.dart';

class SignUpController extends StatelessWidget {
  final SignUpForm _nameForm = new SignUpForm(
    labelText: 'name',
    inputType: TextInputType.text,
    obscureText: false,
    validator: Validation().nameValidator(),
  );

  final SignUpForm _emailForm = new SignUpForm(
    labelText: 'email',
    inputType: TextInputType.emailAddress,
    obscureText: false,
    validator: Validation().emailValidator(),
  );

  final SignUpForm _passwordForm = new SignUpForm(
    labelText: 'password',
    inputType: TextInputType.text,
    obscureText: true,
    validator: Validation().passwordValidator(),
  );

  @override
  Widget build(BuildContext context) {
    final TermsAndConditions _termsAndConditions = new TermsAndConditions();

    final SignUpForm _confirmPasswordForm = new SignUpForm(
        labelText: 'confirm password',
        inputType: TextInputType.text,
        obscureText: true,
        validator: (value) {
          if (value != _passwordForm.controller.text) {
            return 'The passwords doesn\'t mach';
          }
          return null;
        });

    return Column(
      children: <Widget>[
        // name textTormField
        _nameForm,
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
        CreateAccountButton(
          onPressed: () async {
            if (_nameForm.formKey.currentState.validate()) {
              if (_emailForm.formKey.currentState.validate()) {
                if (_passwordForm.formKey.currentState.validate()) {
                  if (_confirmPasswordForm.formKey.currentState.validate()) {
                    UserCredential userCredential =
                        await context.read<AuthenticationController>().signUp(
                              name: _nameForm.controller.text.trim(),
                              email: _emailForm.controller.text.trim(),
                              password: _passwordForm.controller.text.trim(),
                              context: context,
                            );

                    context
                        .read<AuthenticationController>()
                        .signUp(
                          name: _nameForm.controller.text.trim(),
                          email: _emailForm.controller.text.trim(),
                          password: _passwordForm.controller.text.trim(),
                          context: context,
                        )
                        .then((_) {
                      if (userCredential != null) {
                        Navigator.of(context).pop();
                        showEmailVerificationMessage(
                            context, _emailForm.controller.text.trim());
                      }
                    });
                  }
                }
              }
            }
          },
        ),
        // go back to sign in page
        SizedBox(height: 10.0),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
              GestureDetector(
                child: Text('Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    )),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
