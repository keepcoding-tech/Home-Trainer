import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:home_trainer/app/screens/routines/utilities/showAlertDialogMessage.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class DismissAppBar extends StatelessWidget {
  final String title, messageTitle;
  DismissAppBar({this.title, this.messageTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('$title', style: kTitleLabelTextStyle),
      leading: IconButton(
        icon: Icon(
          FontAwesomeIcons.arrowLeft,
          color: kIconColor,
        ),
        onPressed: () {
          showAlertDialogMessage(
            context: context,
            messageTitle: messageTitle,
            messageDetails: 'All changes will be deleted!',
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
