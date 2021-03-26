import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:home_trainer/authentication/services/authenticationController.dart';

class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blueGrey[600],
      child: Text('sign Out'),
      onPressed: () {
        context.read<AuthenticationController>().signOut();
      },
    );
  }
}
