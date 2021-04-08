import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_trainer/app/screens/routines/utilities/editTextFormField.dart';

import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:home_trainer/app/utilities/restTimeCard.dart';
import 'package:home_trainer/app/utilities/unitInputCard.dart';
import 'package:home_trainer/database/exerciseDatabaseController.dart';

enum UnitInput { distance, sessions, restTime, minutes, seconds }

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
        minutesLabelText: int.parse(restTimeMin),
        secondsLabelText: int.parse(restTimeSec),
      );
}

class _EditShortDistanceExerciseControllerState
    extends State<EditShortDistanceExerciseController> {
  int distance;
  String style;
  int sessions;
  int minutesLabelText;
  int secondsLabelText;

  _EditShortDistanceExerciseControllerState({
    this.distance,
    this.style,
    this.sessions,
    this.minutesLabelText,
    this.secondsLabelText,
  });

  Function increase(UnitInput input) {
    return () {
      setState(() {
        if (input == UnitInput.distance) {
          distance += 5;
        } else if (input == UnitInput.sessions) {
          sessions++;
        } else if (input == UnitInput.minutes) {
          if (minutesLabelText < 59) {
            minutesLabelText++;
          } else {
            minutesLabelText = 0;
          }
        } else if (input == UnitInput.seconds) {
          if (secondsLabelText < 59) {
            secondsLabelText++;
          } else {
            secondsLabelText = 0;
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
        } else if (input == UnitInput.minutes) {
          if (minutesLabelText > 0) {
            minutesLabelText--;
          } else {
            minutesLabelText = 59;
          }
        } else if (input == UnitInput.seconds) {
          if (secondsLabelText > 0) {
            secondsLabelText--;
          } else {
            secondsLabelText = 59;
          }
        }
      });
    };
  }

  final Color activeColor = Colors.blueGrey[700];

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
                  labelText: 'DISTANCE',
                  inputText: Text(
                    '${distance.toString()} m',
                    style: kTitleLabelTextStyle,
                  ),
                  cardColor: kActiveCardColor,
                  sizedBoxHeight: 15.0,
                  onPressedMinus: decrease(UnitInput.distance),
                  onPressedPlus: increase(UnitInput.distance),
                ),
              ),
              Expanded(
                child: UnitInputCard(
                  labelText: 'SESSIONS',
                  inputText: Text(
                    sessions.toString(),
                    style: kTitleLabelTextStyle,
                  ),
                  cardColor: kActiveCardColor,
                  sizedBoxHeight: 15.0,
                  onPressedMinus: decrease(UnitInput.sessions),
                  onPressedPlus: increase(UnitInput.sessions),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: RestTimeCard(
            labelText: 'REST TIME',
            cardColor: kActiveCardColor,
            sizedBoxHeight: 5.0,
            minutesLabelText: minutesLabelText,
            secondsLabelText: secondsLabelText,
            onPressedMinusMin: decrease(UnitInput.minutes),
            onPressedPlusMin: increase(UnitInput.minutes),
            onPressedMinusSec: decrease(UnitInput.seconds),
            onPressedPlusSec: increase(UnitInput.seconds),
          ),
        ),
        Expanded(
          child: RoutineButton(
            labelName: 'SAVE',
            color: kButtonColor,
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
                ).createShortDistanceExerciseData(
                  exercise: widget.exerciseTitle,
                  distance: distance.toString(),
                  style: _styleForm.controller.text.trim(),
                  sessions: sessions.toString(),
                  restTimeMin: minutesLabelText.toString(),
                  restTimeSec: secondsLabelText.toString(),
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
