import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

Future<void> showEmailVerificationMessage(
    BuildContext context, String email) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: kActiveCardColor,
        title: Icon(
          FontAwesomeIcons.envelope,
          size: 50.0,
          color: kIconColor,
        ),
        content: Text(
          'An email has bean sent to:\n   "$email", ' +
              'click the link provided to complete registration.',
          style: kContentLabelTextStyle,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: kButtonLabelTextStyle,
            ),
          ),
        ],
      );
    },
  );
}
