import 'package:flutter/material.dart';

Future<void> showAlertDialogMessage({
  BuildContext context,
  String messageTitle,
  String messageDetails,
  Function onPressed,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(messageTitle),
        content: Text(messageDetails),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onPressed();
            },
            child: Text('YES'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('NO'),
          ),
        ],
      );
    },
  );
}
