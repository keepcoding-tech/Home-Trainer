import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/choseSportMessage.dart';

class ActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.blueGrey[900],
      onPressed: () {
        choseSportMessage(context);
      },
    );
  }
}
