import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/routineTextFormField.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/database/routineDatabaseController.dart';

class CyclingFormController extends StatefulWidget {
  @override
  _CyclingFormControllerState createState() => _CyclingFormControllerState();
}

class _CyclingFormControllerState extends State<CyclingFormController> {
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

  List<Map> routines = <Map>[];

  // add new exercise to the routine
  bool addExercise() {
    if (_titleForm.formKey.currentState.validate()) {
      if (_exerciseForm.formKey.currentState.validate()) {
        if (_muscleForm.formKey.currentState.validate()) {
          if (_setsForm.formKey.currentState.validate()) {
            if (_repsForm.formKey.currentState.validate()) {
              if (_weightForm.formKey.currentState.validate()) {
                Map newRoutine = {
                  "exercise": _exerciseForm.controller.text.trim(),
                  "muscle": _muscleForm.controller.text.trim(),
                  "sets": _setsForm.controller.text.trim(),
                  "reps": _repsForm.controller.text.trim(),
                  "kg": _weightForm.controller.text.trim(),
                };
                routines.add(newRoutine);

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
    final String sport = 'CYCLING';

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
              await RoutineDatabaseController().updateRoutineData(
                title: _titleForm.controller.text.trim(),
                routines: routines,
                sport: sport,
              );

              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
