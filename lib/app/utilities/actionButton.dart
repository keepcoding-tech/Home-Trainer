import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:home_trainer/app/utilities/constantsStyles.dart';

class ActionButton extends StatelessWidget {
  final Function onPressed;
  ActionButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        FontAwesomeIcons.plus,
        color: kIconColor,
      ),
      backgroundColor: kButtonColor,
      onPressed: onPressed,
    );
  }
}
