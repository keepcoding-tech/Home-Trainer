import 'package:flutter/material.dart';

Future<void> cancelRoutineMessage(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Discard routine'),
        content: Text(
          'Are you sure?\n The routine will be deleted',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('YES'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('NO'),
          ),
        ],
      );
    },
  );
}
