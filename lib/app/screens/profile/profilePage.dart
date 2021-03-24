import 'package:flutter/material.dart';
import 'package:home_trainer/app/screens/profile/services/profileController.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ProfileController(),
        ),
      ),
    );
  }
}
