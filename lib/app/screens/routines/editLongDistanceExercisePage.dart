import 'package:flutter/material.dart';
import 'package:home_trainer/app/screens/routines/services/editLongDistanceExerciseController.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineAppBar.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DismissAppBar(
          messageTitle: 'Dismiss changes',
          title: 'EDIT',
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
