import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 12.0,
          left: MediaQuery.of(context).size.width / 10.0),
      width: MediaQuery.of(context).size.width / 2.5,
      height: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/defaultUser.png'),
        ),
      ),
    );
  }
}
