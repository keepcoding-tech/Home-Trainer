import 'package:flutter/material.dart';
import 'package:home_trainer/app/screens/routines/services/editLongDistanceExerciseController.dart';

class EditLongDistanceExercisePage extends StatelessWidget {
  final String routineTitle,
      exerciseTitle,
      distance,
      intervals,
      intensity,
      restTimeMin,
      restTimeSec,
      intensityTextLabe;
  EditLongDistanceExercisePage({
    this.routineTitle,
    this.exerciseTitle,
    this.distance,
    this.intensity,
    this.intervals,
    this.restTimeMin,
    this.restTimeSec,
    this.intensityTextLabe,
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
        child: EditLongDistanceExerciseController(
          routine: routineTitle,
          exercise: exerciseTitle,
          distance: distance,
          intervals: intervals,
          intensity: intensity,
          restTimeMin: restTimeMin,
          restTimeSec: restTimeSec,
          intensityTextLabel: intensityTextLabe,
        ),
      ),
    );
  }
}
