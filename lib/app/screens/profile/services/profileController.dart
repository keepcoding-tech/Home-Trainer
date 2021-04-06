import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:home_trainer/app/screens/profile/utilities/headerCurvedContainer.dart';
import 'package:home_trainer/app/screens/profile/utilities/profileImage.dart';
import 'package:home_trainer/app/screens/profile/utilities/userCredentialData.dart';
import 'package:home_trainer/app/screens/profile/utilities/userData.dart';

class ProfileController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomPaint(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          painter: HeaderCurvedContainer(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // profiel image
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: ProfileImage(imageWidth: 2),
            ),
            SizedBox(height: 25.0),
            // user name
            UserCredentialData(
              userCredentialData: UserName(),
              icon: FontAwesomeIcons.user,
            ),
            // user email
            SizedBox(height: 15.0),
            UserCredentialData(
              userCredentialData: UserEmail(),
              icon: FontAwesomeIcons.envelope,
            ),
          ],
        ),
      ],
    );
  }
}
