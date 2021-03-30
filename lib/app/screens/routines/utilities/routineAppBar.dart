import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/deleteRoutineMessage.dart';

class RoutineAppBar extends StatelessWidget {
  final String title;
  RoutineAppBar({this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text('Create $title routine')),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          showAlertDialogMessage(
            context: context,
            messageTitle: 'Dismis Routine',
            messageDetails: 'Are you sure? All the changes will be deleted.',
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
