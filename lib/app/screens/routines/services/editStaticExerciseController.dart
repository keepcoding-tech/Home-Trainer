import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/editTextFormField.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:home_trainer/app/utilities/restTimeCard.dart';
import 'package:home_trainer/app/utilities/unitInputCard.dart';
import 'package:home_trainer/database/exerciseDatabaseController.dart';

enum UnitInput { sets, reps, weight, minutes, seconds }

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
        minutesLabelText: int.parse(restTimeMin),
        secondsLabelText: int.parse(restTimeSec),
      );
}

class _EditStaticExerciseControllerState
    extends State<EditStaticExerciseController> {
  int sets, reps, minutesLabelText, secondsLabelText;
  double weight;

  _EditStaticExerciseControllerState({
    this.sets,
    this.reps,
    this.weight,
    this.minutesLabelText,
    this.secondsLabelText,
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
        if (input == UnitInput.sets && sets > 1) {
          sets--;
        } else if (input == UnitInput.reps && reps > 1) {
          reps--;
        } else if (input == UnitInput.weight && weight > 0) {
          weight -= 0.5;
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
                  labelText: 'SETS',
                  inputText: Text(
                    sets.toString(),
                    style: kTitleLabelTextStyle,
                  ),
                  cardColor: kActiveCardColor,
                  sizedBoxHeight: 10.0,
                  onPressedMinus: decrease(UnitInput.sets),
                  onPressedPlus: increase(UnitInput.sets),
                ),
              ),
              Expanded(
                child: UnitInputCard(
                  labelText: 'REPS',
                  inputText: Text(
                    reps.toString(),
                    style: kTitleLabelTextStyle,
                  ),
                  cardColor: kActiveCardColor,
                  sizedBoxHeight: 10.0,
                  onPressedMinus: decrease(UnitInput.reps),
                  onPressedPlus: increase(UnitInput.reps),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: UnitInputCard(
            labelText: 'WEIGHT',
            inputText: Text(
              weight.toString(),
              style: kTitleLabelTextStyle,
            ),
            cardColor: kActiveCardColor,
            sizedBoxHeight: 10.0,
            onPressedMinus: decrease(UnitInput.weight),
            onPressedPlus: increase(UnitInput.weight),
          ),
        ),
        Expanded(
          flex: 2,
          child: RestTimeCard(
            labelText: 'REST TIME',
            cardColor: kActiveCardColor,
            sizedBoxHeight: 8.0,
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
                  ).createStaticExerciseData(
                    exercise: _exerciseForm.controller.text.trim(),
                    muscle: _muscleForm.controller.text.trim(),
                    sets: sets.toString(),
                    reps: reps.toString(),
                    weight: weight.toString(),
                    restTimeMin: minutesLabelText.toString(),
                    restTimeSec: secondsLabelText.toString(),
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
