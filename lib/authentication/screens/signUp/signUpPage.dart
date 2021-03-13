import 'package:flutter/material.dart';
import 'package:home_trainer/authentication/screens/signUp/services/signUpController.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Sign Up')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SignUpController(),
        ),
      ),
    );
  }
}
