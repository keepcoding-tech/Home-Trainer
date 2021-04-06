import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class LoginButton extends StatelessWidget {
  LoginButton({this.onPressed});
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      color: kIconColor,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(
        'LOGIN',
        style: TextStyle(
          color: kLightBackgroundColor,
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class SocialMediaLogin extends StatelessWidget {
  SocialMediaLogin({
    this.buttonColor,
    this.icon,
    this.onPressed,
  });
  final Color buttonColor;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(
        height: 80.0,
        width: 80.0,
      ),
      elevation: 6.0,
      shape: CircleBorder(),
      fillColor: buttonColor,
      child: Icon(icon, size: 55, color: kIconColor),
      onPressed: onPressed,
    );
  }
}
