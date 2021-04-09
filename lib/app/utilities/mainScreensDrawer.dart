import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/profile/services/updateUserInfoGeneticsData.dart';
import 'package:home_trainer/app/screens/profile/utilities/userCredentialData.dart';
import 'package:home_trainer/app/screens/profile/utilities/profileImage.dart';
import 'package:home_trainer/app/screens/profile/utilities/signOutButton.dart';
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
              GestureDetector(
                onTap: () {
                  print('stopwach');
                },
                child: Container(
                  color: kActiveCardColor,
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.stopwatch,
                      color: kIconColor,
                    ),
                    title: Text(
                      'STOPWATCH',
                      style: kSubtitleLabelTextStyle,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  print('timer');
                },
                child: Container(
                  color: kActiveCardColor,
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.solidClock,
                      color: kIconColor,
                    ),
                    title: Text('TIMER', style: kSubtitleLabelTextStyle),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateUserInfoGeneticsData(),
                    ),
                  );
                },
                child: Container(
                  color: kActiveCardColor,
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.solidFileAlt,
                      color: kIconColor,
                    ),
                    title: Text('UPDATE INFO', style: kSubtitleLabelTextStyle),
                  ),
                ),
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
