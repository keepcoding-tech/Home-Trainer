import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:provider/provider.dart';

import 'package:home_trainer/authentication/services/authenticationController.dart';

class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: kActiveCardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.signOutAlt,
            color: kIconColor,
          ),
          SizedBox(width: 15.0),
          Text(
            'SIGN OUT',
            style: kSubtitleLabelTextStyle,
          ),
        ],
      ),
      onPressed: () {
        context.read<AuthenticationController>().signOut();
      },
    );
  }
}
