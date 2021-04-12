import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class DetailExerciseCard extends StatelessWidget {
  const DetailExerciseCard({this.cardChild});
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1.0),
      height: 56.0,
      child: Card(
        color: kActiveCardColor,
        child: Center(
          child: cardChild,
        ),
      ),
    );
  }
}
