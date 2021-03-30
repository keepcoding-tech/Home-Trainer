import 'package:flutter/material.dart';
import 'package:home_trainer/app/screens/routines/services/editExerciseController.dart';

class EditExercisePage extends StatefulWidget {
  final String routineTitle, exerciseTitle, muscle, sets, reps, weight;
  EditExercisePage({
    this.routineTitle,
    this.exerciseTitle,
    this.muscle,
    this.sets,
    this.reps,
    this.weight,
  });

  @override
  _EditExercisePageState createState() => _EditExercisePageState();
}

class _EditExercisePageState extends State<EditExercisePage> {
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
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              print('save');
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: EditExerciseController(
            routineTitle: widget.routineTitle,
            exerciseTitle: widget.exerciseTitle,
            muscle: widget.muscle,
            sets: widget.sets,
            reps: widget.reps,
            weight: widget.weight,
          ),
        ),
      ),
    );
  }
}
