import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/authentication/screens/createUserInfo/services/createUserInfoName.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:home_trainer/authentication/utilities/authenticationHeaderCurvedContainer.dart';

class CreateUserInfoPage extends StatefulWidget {
  final String email, password, authMethod;
  CreateUserInfoPage({this.email, this.password, this.authMethod});

  @override
  _CreateUserInfoPageState createState() => _CreateUserInfoPageState();
}

class _CreateUserInfoPageState extends State<CreateUserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CREATE USER INFO',
          style: kTitleLabelTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: kIconColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                      child: CreateUserInfoName(
                        email: widget.email,
                        password: widget.password,
                        authMethod: widget.authMethod,
                      ),
                    ),
                  ),
                  SizedBox(height: 200.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
