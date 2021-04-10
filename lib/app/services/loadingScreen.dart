import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

// class LoadingScreen extends StatefulWidget {
//   final double loadingSize;
//   LoadingScreen({this.loadingSize});

//   @override
//   _LoadingScreenState createState() => _LoadingScreenState();
// }

// class _LoadingScreenState extends State<LoadingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [],
//         ),
//       ),
//     );
//   }
// }

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
