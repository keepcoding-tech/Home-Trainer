import 'package:flutter/material.dart';

import 'package:home_trainer/authentication/screens/signIn/utilities/resetPassword.dart';
import 'package:home_trainer/authentication/screens/signUp/signUpPage.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class SignInTexts {
  Widget signInTitle() {
    return Text(
      'SIGN IN',
      style: kTitleLabelTextStyle,
    );
  }

  Widget forgotPassword(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showResetPassword(
          context,
        );
      },
      child: Text(
        'Forgot password?',
        style: kContentLabelTextStyle,
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
            style: kContentLabelTextStyle,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text(
              'SIGN UP',
              style: kBoldContentLabelTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
