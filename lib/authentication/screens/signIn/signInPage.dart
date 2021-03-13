import 'package:flutter/material.dart';

import 'package:home_trainer/authentication/screens/signIn/services/signInController.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Sign In')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SignInController(),
        ),
      ),
    );
  }
}
