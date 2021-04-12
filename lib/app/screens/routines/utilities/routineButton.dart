import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class RoutineButton extends StatelessWidget {
  RoutineButton({this.onPressed, this.labelName, this.color});
  final Color color;
  final String labelName;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: Text(
            labelName,
            style: kRoutineButtonLabelTextStyle,
          ),
        ),
      ),
    );
  }
}
