import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:home_trainer/authentication/services/authenticationController.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/emailVerificationMessage.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/termsAndConditions.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/createAccountButton.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/signUpForm.dart';

class SignUpController extends StatelessWidget {
  final SignUpForm _emailForm = new SignUpForm(
    labelText: 'email',
    inputType: TextInputType.emailAddress,
    obscureText: false,
    validator: (value) {
      if (value.isEmpty) {
        return 'An email is required';
      }
      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+" +
              "-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return 'Enter a valid email';
      }
      return null;
    },
  );

  final SignUpForm _passwordForm = new SignUpForm(
    labelText: 'password',
    inputType: TextInputType.text,
    obscureText: true,
    validator: (value) {
      if (value.isEmpty) {
        return 'A password is required';
      }
      if (value.length < 6) {
        return 'Password must be at least 6 characters';
      }
      return null;
    },
  );
  @override
  Widget build(BuildContext context) {
    final TermsAndConditions _checkboxTerms = new TermsAndConditions();

    final SignUpForm _confirmPasswordForm = new SignUpForm(
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

    return Column(
      children: <Widget>[
        // email textTormField
        _emailForm,
        // password textTormField
        _passwordForm,
        // confirm password textTormField
        _confirmPasswordForm,
        // agree to terms and conditions
        _checkboxTerms,
        SizedBox(height: 20.0),
        // create account button
        CreateAccountButton(
          onPressed: () async {
            if (_emailForm.formKey.currentState.validate()) {
              if (_passwordForm.formKey.currentState.validate()) {
                if (_confirmPasswordForm.formKey.currentState.validate()) {
                  UserCredential userCredential =
                      await context.read<AuthenticationController>().signUp(
                            email: _emailForm.controller.text.trim(),
                            password: _passwordForm.controller.text.trim(),
                            context: context,
                          );

                  context
                      .read<AuthenticationController>()
                      .signUp(
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
          },
        ),
        SizedBox(height: 10.0),
        // go back to sign in page
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
