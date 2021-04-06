import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

import 'package:home_trainer/authentication/screens/signIn/services/signInController.dart';
import 'package:home_trainer/authentication/screens/signIn/utilities/signInTexts.dart';
import 'package:home_trainer/authentication/utilities/authenticationHeaderCurvedContainer.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                      child: SignInController(),
                    ),
                  ),
                  SignInTexts().dontHaveAccountText(context),
                  SizedBox(height: 30.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
