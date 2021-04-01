import 'package:flutter/material.dart';

class UserCredentialData extends StatelessWidget {
  final userCredentialData;
  final IconData icon;
  UserCredentialData({this.userCredentialData, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      color: Colors.blueGrey[600],
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4.5),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey[800]),
        title: userCredentialData,
      ),
    );
  }
}
