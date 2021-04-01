import 'package:flutter/material.dart';

class RoutineButton extends StatelessWidget {
  final String labelName;
  final Function onPressed;
  RoutineButton({this.onPressed, this.labelName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blueGrey[700],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            labelName,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
