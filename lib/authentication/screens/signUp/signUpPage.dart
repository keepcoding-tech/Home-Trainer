import 'package:flutter/material.dart';

import 'package:home_trainer/authentication/screens/signUp/services/signUpController.dart';
import 'package:home_trainer/authentication/screens/signUp/utilities/signUpTexts.dart';
import 'package:home_trainer/authentication/utilities/authenticationHeaderCurvedContainer.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              CustomPaint(
                child: Container(width: 600, height: 600),
                painter: AuthenticationHeaderCurvedContainer(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: 80.0, right: 40.0, bottom: 30.0, left: 40.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kLightBackgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SignUpController(),
                    ),
                  ),
                  SignUpTexts().alreadyHaveAnAccount(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
