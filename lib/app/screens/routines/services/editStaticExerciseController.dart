import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/editTextFormField.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/app/screens/routines/utilities/unitInputCard.dart';
import 'package:home_trainer/database/exerciseDatabaseController.dart';

enum UnitInput { sets, reps, weight, restTime }

class EditStaticExerciseController extends StatefulWidget {
  final String routineTitle,
      exerciseTitle,
      muscle,
      sets,
      reps,
      weight,
      restTimeMin,
      restTimeSec;
  EditStaticExerciseController({
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
  _EditStaticExerciseControllerState createState() =>
      _EditStaticExerciseControllerState(
        sets: int.parse(sets),
        reps: int.parse(reps),
        weight: double.parse(weight),
        restTimeMin: int.parse(restTimeMin),
        restTimeSec: int.parse(restTimeSec),
      );
}

class _EditStaticExerciseControllerState
    extends State<EditStaticExerciseController> {
  int sets, reps, restTimeMin, restTimeSec;
  double weight;

  _EditStaticExerciseControllerState({
    this.sets,
    this.reps,
    this.weight,
    this.restTimeMin,
    this.restTimeSec,
  });

  Function increase(UnitInput input) {
    return () {
      setState(() {
        if (input == UnitInput.sets) {
          sets++;
        } else if (input == UnitInput.reps) {
          reps++;
        } else if (input == UnitInput.weight) {
          weight += 0.5;
        } else if (input == UnitInput.restTime && restTimeMin < 60) {
          if (restTimeSec == 30) {
            restTimeSec = 0;
            restTimeMin++;
          } else {
            restTimeSec = 30;
          }
        }
      });
    };
  }

  Function decrease(UnitInput input) {
    return () {
      setState(() {
        if (input == UnitInput.sets && sets > 1) {
          sets--;
        } else if (input == UnitInput.reps && reps > 1) {
          reps--;
        } else if (input == UnitInput.weight && weight > 0) {
          weight -= 0.5;
        } else if (input == UnitInput.restTime &&
            (restTimeMin > 0 || restTimeSec > 0)) {
          if (restTimeSec == 0) {
            restTimeSec = 30;
            restTimeMin--;
          } else {
            restTimeSec = 0;
          }
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    final _currentUser = FirebaseAuth.instance.currentUser;
    final CollectionReference _routineColection =
        FirebaseFirestore.instance.collection('users');

    EditTextFormField _exerciseForm = new EditTextFormField(
      labelText: 'exercise',
      defaultData: widget.exerciseTitle,
    );
    EditTextFormField _muscleForm = EditTextFormField(
      labelText: 'muscle',
      defaultData: widget.muscle,
    );

    return Column(
      children: <Widget>[
        // exercise text form field
        Expanded(child: _exerciseForm),
        // muscle text form field
        Expanded(child: _muscleForm),
        // sets, reps and weight fields
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              Expanded(
                child: UnitInputCard(
                  labelText: 'Sets',
                  inputText: Text(
                    sets.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                  onPressedMinus: decrease(UnitInput.sets),
                  onPressedPlus: increase(UnitInput.sets),
                ),
              ),
              Expanded(
                child: UnitInputCard(
                  labelText: 'Reps',
                  inputText: Text(
                    reps.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                  onPressedMinus: decrease(UnitInput.reps),
                  onPressedPlus: increase(UnitInput.reps),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              Expanded(
                child: UnitInputCard(
                  labelText: 'Weight',
                  inputText: Text(
                    weight.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                  onPressedMinus: decrease(UnitInput.weight),
                  onPressedPlus: increase(UnitInput.weight),
                ),
              ),
              Expanded(
                child: UnitInputCard(
                  labelText: 'Rest time',
                  inputText: Text(
                    restTimeMin > 9
                        ? '$restTimeMin : $restTimeSec'
                        : '0$restTimeMin : $restTimeSec',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                  onPressedMinus: decrease(UnitInput.restTime),
                  onPressedPlus: increase(UnitInput.restTime),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RoutineButton(
            labelName: 'SAVE',
            onPressed: () async {
              if (_exerciseForm.formKey.currentState.validate()) {
                if (_muscleForm.formKey.currentState.validate()) {
                  _routineColection
                      .doc(_currentUser.uid)
                      .collection('routines')
                      .doc(widget.routineTitle)
                      .collection('exercises')
                      .doc(widget.exerciseTitle)
                      .delete();

                  await ExerciseDatabaseController(
                    routineTitle: widget.routineTitle,
                  ).updateStaticExerciseData(
                    exercise: _exerciseForm.controller.text.trim(),
                    muscle: _muscleForm.controller.text.trim(),
                    sets: sets.toString(),
                    reps: reps.toString(),
                    weight: weight.toString(),
                    restTimeMin: restTimeMin.toString(),
                    restTimeSec: restTimeSec.toString(),
                  );

                  Navigator.pop(context);
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
