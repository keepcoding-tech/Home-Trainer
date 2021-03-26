import 'package:flutter/material.dart';

class SignInButtons extends StatelessWidget {
  SignInButtons(
      {this.buttonText, this.buttonColor, this.textColor, this.onPressed});
  final Color buttonColor, textColor;
  final String buttonText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: buttonColor,
      child: Text(
        buttonText,
        style: TextStyle(color: textColor),
      ),
      onPressed: onPressed,
    );
  }
}
