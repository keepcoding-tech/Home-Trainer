import 'package:flutter/material.dart';

class SelectableCard extends StatelessWidget {
  SelectableCard({
    this.cardChild,
    this.color,
    this.onPressed,
  });
  final Widget cardChild;
  final Color color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
