import 'package:flutter/material.dart';

Future<void> showEmailVerificationMessage(
    BuildContext context, String email) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Verify your email'),
        content: Text(
          'An email has bean sent to: "$email", ' +
              'Click the link provided to complete registration.',
        ),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK')),
        ],
      );
    },
  );
}
