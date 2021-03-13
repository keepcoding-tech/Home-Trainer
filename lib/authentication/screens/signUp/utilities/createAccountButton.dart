import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  CreateAccountButton({this.onPressed});
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton(
      color: Colors.white,
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
