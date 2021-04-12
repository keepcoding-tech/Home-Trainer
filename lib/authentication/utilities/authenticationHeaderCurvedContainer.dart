import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class AuthenticationHeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = kPrimariColor;
    Path path = Path()
      ..relativeLineTo(0, 450)
      ..quadraticBezierTo(size.width / 2, 550, size.width, 450)
      ..relativeLineTo(0, -450)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
