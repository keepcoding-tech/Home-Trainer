import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/routineTextFormField.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/database/exerciseDatabaseController.dart';
import 'package:home_trainer/database/routineDatabaseController.dart';
import 'package:home_trainer/database/utilities/exercise.dart';

class GymFormController extends StatefulWidget {
  @override
  _GymFormControllerState createState() => _GymFormControllerState();
}

class _GymFormControllerState extends State<GymFormController> {
  RoutineTextFormField _titleForm = new RoutineTextFormField(
    labelText: 'title',
  );
  RoutineTextFormField _exerciseForm = new RoutineTextFormField(
    labelText: 'exercise',
  );
  RoutineTextFormField _muscleForm = new RoutineTextFormField(
    labelText: 'muscle group',
  );
  RoutineTextFormField _setsForm = new RoutineTextFormField(
    labelText: 'sets',
  );
  RoutineTextFormField _repsForm = new RoutineTextFormField(
    labelText: 'reps',
  );
  RoutineTextFormField _weightForm = new RoutineTextFormField(
    labelText: 'kg',
  );

  List<Exercise> routine = <Exercise>[];

  // add new exercise to the routine
  bool addExercise() {
    if (_titleForm.formKey.currentState.validate()) {
      if (_exerciseForm.formKey.currentState.validate()) {
        if (_muscleForm.formKey.currentState.validate()) {
          if (_setsForm.formKey.currentState.validate()) {
            if (_repsForm.formKey.currentState.validate()) {
              if (_weightForm.formKey.currentState.validate()) {
                Exercise newRoutine = new Exercise(
                  exercise: _exerciseForm.controller.text.trim(),
                  muscle: _muscleForm.controller.text.trim(),
                  sets: _setsForm.controller.text.trim(),
                  reps: _repsForm.controller.text.trim(),
                  weight: _weightForm.controller.text.trim(),
                );
                routine.add(newRoutine);

                return true;
              }
            }
          }
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final String sport = 'GYM';

    return Column(
      children: <Widget>[
        // title text form filed
        _titleForm,
        // exercise text form field
        _exerciseForm,
        // muscle text form field
        _muscleForm,
        // sets, reps and weight fields
        Container(
          margin: EdgeInsets.all(10.0),
          color: Colors.blueGrey[600],
          child: Row(
            children: <Widget>[
              Expanded(child: _setsForm),
              Expanded(child: _repsForm),
              Expanded(child: _weightForm),
            ],
          ),
        ),
        // add new exercise button
        CreateRoutineButton(
          labelName: 'ADD NEW EXERCISE',
          onPressed: () async {
            if (addExercise()) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Exercise added to routine')));

              _exerciseForm.controller.clear();
              _muscleForm.controller.clear();
              _setsForm.controller.clear();
              _repsForm.controller.clear();
              _weightForm.controller.clear();
            }
          },
        ),
        // create routine button
        CreateRoutineButton(
          labelName: 'CREATE ROUTINE',
          onPressed: () async {
            if (addExercise()) {
              // create new routine
              await RoutineDatabaseController().createRoutineData(
                title: _titleForm.controller.text.trim(),
                sport: sport,
              );

              for (int i = 0; i < routine.length; i++) {
                await ExerciseDatabaseController(
                  routineTitle: _titleForm.controller.text.trim(),
                ).createExerciseData(
                  exerciseTitle: routine[i].exercise,
                  muscle: routine[i].muscle,
                  sets: routine[i].sets,
                  reps: routine[i].reps,
                  weight: routine[i].weight,
                );
              }

              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
