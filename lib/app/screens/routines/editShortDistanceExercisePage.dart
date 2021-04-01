import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/services/editShortDistanceExerciseController.dart';

class EditShortDistanceExercisePage extends StatelessWidget {
  final String routineTitle,
      exerciseTitle,
      distance,
      style,
      sessions,
      restTimeMin,
      restTimeSec;
  EditShortDistanceExercisePage({
    this.routineTitle,
    this.exerciseTitle,
    this.distance,
    this.style,
    this.sessions,
    this.restTimeMin,
    this.restTimeSec,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EDIT'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: EditShortDistanceExerciseController(
              routineTitle: routineTitle,
              exerciseTitle: exerciseTitle,
              distance: distance,
              style: style,
              sessions: sessions,
              restTimeMin: restTimeMin,
              restTimeSec: restTimeSec,
            ),
          ),
        ),
      ),
    );
  }
}
