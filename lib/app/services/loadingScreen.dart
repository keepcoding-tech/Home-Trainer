import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitHourGlass(
          color: kIconColor,
          size: 50.0,
        ),
      ),
    );
  }
}

class LoadingAnimation extends StatelessWidget {
  final double loadingSize;
  LoadingAnimation({this.loadingSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitHourGlass(
          color: kIconColor,
          size: loadingSize,
        ),
      ),
    );
  }
}
