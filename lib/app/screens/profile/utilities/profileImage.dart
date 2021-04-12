import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double imageWidth;
  ProfileImage({this.imageWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / imageWidth,
      height: MediaQuery.of(context).size.width / imageWidth,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/defaultUser.png'),
        ),
      ),
    );
  }
}
