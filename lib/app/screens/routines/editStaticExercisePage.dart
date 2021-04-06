import 'package:flutter/material.dart';
import 'package:home_trainer/app/screens/routines/services/editStaticExerciseController.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineAppBar.dart';

class EditStaticExercisePage extends StatelessWidget {
  final String routineTitle,
      exerciseTitle,
      muscle,
      sets,
      reps,
      weight,
      restTimeMin,
      restTimeSec;
  EditStaticExercisePage({
    this.routineTitle,
    this.exerciseTitle,
    this.muscle,
    this.sets,
    this.reps,
    this.weight,
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
            child: EditStaticExerciseController(
              routineTitle: routineTitle,
              exerciseTitle: exerciseTitle,
              muscle: muscle,
              sets: sets,
              reps: reps,
              weight: weight,
              restTimeMin: restTimeMin,
              restTimeSec: restTimeSec,
            ),
          ),
        ),
      ),
    );
  }
}
