import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_trainer/app/screens/routines/utilities/editTextFormField.dart';

import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/app/screens/routines/utilities/unitInputCard.dart';
import 'package:home_trainer/database/exerciseDatabaseController.dart';

enum UnitInput { distance, sessions, restTime }

class EditShortDistanceExerciseController extends StatefulWidget {
  final String routineTitle,
      exerciseTitle,
      distance,
      style,
      sessions,
      restTimeMin,
      restTimeSec;
  EditShortDistanceExerciseController({
    this.routineTitle,
    this.exerciseTitle,
    this.distance,
    this.style,
    this.sessions,
    this.restTimeMin,
    this.restTimeSec,
  });

  @override
  _EditShortDistanceExerciseControllerState createState() =>
      _EditShortDistanceExerciseControllerState(
        distance: int.parse(distance),
        style: style,
        sessions: int.parse(sessions),
        restTimeMin: int.parse(restTimeMin),
        restTimeSec: int.parse(restTimeSec),
      );
}

class _EditShortDistanceExerciseControllerState
    extends State<EditShortDistanceExerciseController> {
  int distance;
  String style;
  int sessions;
  int restTimeMin;
  int restTimeSec;

  _EditShortDistanceExerciseControllerState({
    this.distance,
    this.style,
    this.sessions,
    this.restTimeMin,
    this.restTimeSec,
  });

  Function increase(UnitInput input) {
    return () {
      setState(() {
        if (input == UnitInput.distance) {
          distance += 5;
        } else if (input == UnitInput.sessions) {
          sessions++;
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
        if (input == UnitInput.distance && distance > 0) {
          distance -= 5;
        } else if (input == UnitInput.sessions && sessions > 1) {
          sessions--;
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

    EditTextFormField _styleForm = EditTextFormField(
      labelText: 'Style',
      defaultData: style,
    );

    return Column(
      children: <Widget>[
        // style text form field
        Expanded(child: _styleForm),
        // sets, reps and weight fields
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              Expanded(
                child: UnitInputCard(
                  labelText: 'Distance',
                  inputText: Text(
                    '${distance.toString()} m',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                  onPressedMinus: decrease(UnitInput.distance),
                  onPressedPlus: increase(UnitInput.distance),
                ),
              ),
              Expanded(
                child: UnitInputCard(
                  labelText: 'Sessions',
                  inputText: Text(
                    sessions.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                  onPressedMinus: decrease(UnitInput.sessions),
                  onPressedPlus: increase(UnitInput.sessions),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
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
        Expanded(
          child: RoutineButton(
            labelName: 'SAVE',
            onPressed: () async {
              if (_styleForm.formKey.currentState.validate()) {
                _routineColection
                    .doc(_currentUser.uid)
                    .collection('routines')
                    .doc(widget.routineTitle)
                    .collection('exercises')
                    .doc(widget.exerciseTitle)
                    .delete();

                await ExerciseDatabaseController(
                  routineTitle: widget.routineTitle,
                ).updateShortDistanceExerciseData(
                  exerciseTitle: widget.exerciseTitle,
                  distance: distance.toString(),
                  style: _styleForm.controller.text.trim(),
                  sessions: sessions.toString(),
                  restTimeMin: restTimeMin.toString(),
                  restTimeSec: restTimeSec.toString(),
                );

                Navigator.pop(context);
              }
            },
          ),
        ),
      ],
    );
  }
}
