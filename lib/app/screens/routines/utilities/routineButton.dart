import 'package:flutter/material.dart';

class CreateRoutineButton extends StatelessWidget {
  final String labelName;
  final Function onPressed;
  CreateRoutineButton({this.onPressed, this.labelName});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      child: Text(
        labelName,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
