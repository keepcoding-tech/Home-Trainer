import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_trainer/app/screens/profile/utilities/profileImage.dart';
import 'package:home_trainer/app/screens/profile/utilities/signOutButton.dart';
import 'package:home_trainer/app/screens/profile/utilities/userCredentialData.dart';
import 'package:home_trainer/app/screens/profile/utilities/userData.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class MainScreensDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            color: kBackgroundColor,
          ),
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 250.0,
                color: kInactiveCardColor,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    ProfileImage(imageWidth: 3),
                    SizedBox(height: 18.0),
                    UserCredentialData(userCredentialData: UserName())
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              UserCredentialData(
                userCredentialData: Text(
                  'STOPWATCH',
                  style: kSubtitleLabelTextStyle,
                ),
                icon: FontAwesomeIcons.stopwatch,
              ),
              SizedBox(height: 10.0),
              UserCredentialData(
                userCredentialData: Text(
                  'TIMER',
                  style: kSubtitleLabelTextStyle,
                ),
                icon: FontAwesomeIcons.solidClock,
              ),
              Expanded(child: SizedBox()),
              Align(
                alignment: Alignment.bottomRight,
                child: SignOutButton(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
