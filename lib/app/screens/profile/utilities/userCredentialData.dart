import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class UserCredentialData extends StatelessWidget {
  final userCredentialData;
  final IconData icon;
  UserCredentialData({this.userCredentialData, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kActiveCardColor,
      child: ListTile(
        leading: Icon(icon, color: kIconColor),
        title: userCredentialData,
      ),
    );
  }
}
