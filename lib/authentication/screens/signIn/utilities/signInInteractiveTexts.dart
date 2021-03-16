import 'package:flutter/material.dart';
import 'package:home_trainer/authentication/screens/signIn/utilities/resetPassword.dart';

import 'package:home_trainer/authentication/screens/signUp/signUpPage.dart';

class SignInTexts {
  Widget forgotPassword(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showResetPassword(context);
      },
      child: Text(
        'Forgot password?',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget dontHaveAccountText(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account? ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
