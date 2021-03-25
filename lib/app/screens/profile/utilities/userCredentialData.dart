import 'package:flutter/material.dart';

class UserCredentialData extends StatelessWidget {
  final userCredentialData;
  UserCredentialData({this.userCredentialData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      color: Colors.blueGrey[600],
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4.5),
      child: ListTile(
        leading: Icon(Icons.person, color: Colors.blueGrey[800]),
        title: userCredentialData,
      ),
    );
  }
}
