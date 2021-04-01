import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  const RoundIconButton({this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(
        height: 50.0,
        width: 50.0,
      ),
      elevation: 6.0,
      shape: CircleBorder(),
      fillColor: Colors.blueGrey[700],
      child: Icon(icon, color: Colors.white),
      onPressed: onPressed,
    );
  }
}
