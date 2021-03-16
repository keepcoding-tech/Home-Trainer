import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:home_trainer/authentication/services/authenticationController.dart';

Future<void> showResetPassword(BuildContext context) {
  final TextEditingController controller = TextEditingController();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter an email to reset your password'),
        content: TextField(
          autofocus: true,
          controller: controller,
          decoration: InputDecoration(
            hintText: 'email',
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                context
                    .read<AuthenticationController>()
                    .resetPassword(email: controller.text.trim());
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      );
    },
  );
}
