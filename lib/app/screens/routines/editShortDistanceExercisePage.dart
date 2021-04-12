import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/services/editShortDistanceExerciseController.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineAppBar.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DismissAppBar(
          messageTitle: 'Dismiss changes',
          title: 'EDIT',
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
