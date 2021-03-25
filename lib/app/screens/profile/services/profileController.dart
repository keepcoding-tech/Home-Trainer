import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/profile/utilities/profileImage.dart';
import 'package:home_trainer/app/screens/profile/utilities/signOutButton.dart';
import 'package:home_trainer/app/screens/profile/utilities/userCredentialData.dart';
import 'package:home_trainer/app/screens/profile/utilities/userData.dart';

class ProfileController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 5.0,
          color: Colors.blueGrey[800],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // profiel image
            ProfileImage(),
            // user name
            SizedBox(height: 25.0),
            UserCredentialData(userCredentialData: UserName()),
            // user email
            SizedBox(height: 15.0),
            UserCredentialData(userCredentialData: UserEmail()),
          ],
        ),
        // sign out button
        Align(
          alignment: Alignment.bottomRight,
          child: SignOutButton(),
        ),
      ],
    );
  }
}
