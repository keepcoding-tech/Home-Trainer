import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class SignUpTexts {
  Widget signUpTitle() {
    return Text(
      'SIGN UP',
      style: kTitleLabelTextStyle,
    );
  }

  Widget alreadyHaveAnAccount(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account? ',
            style: kContentLabelTextStyle,
          ),
          GestureDetector(
            child: Text(
              'SIGN IN',
              style: kBoldContentLabelTextStyle,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
