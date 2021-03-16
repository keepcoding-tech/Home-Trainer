import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:home_trainer/authentication/services/authenticationController.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile Page!')),
      ),
      body: SafeArea(
        child: Center(
          // ignore: deprecated_member_use
          child: FlatButton(
            color: Colors.white,
            child: Text('sign Out'),
            onPressed: () {
              context.read<AuthenticationController>().signOut();
            },
          ),
        ),
      ),
    );
  }
}
