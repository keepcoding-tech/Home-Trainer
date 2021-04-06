import 'package:flutter/material.dart';
import 'package:home_trainer/app/screens/profile/services/profileController.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:home_trainer/app/utilities/mainScreensDrawer.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PROFILE',
          style: kTitleLabelTextStyle,
        ),
      ),
      drawer: MainScreensDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ProfileController(),
        ),
      ),
    );
  }
}
