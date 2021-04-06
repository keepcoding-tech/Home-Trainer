import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/routineTextFormField.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:home_trainer/app/utilities/unitInputCard.dart';
import 'package:home_trainer/database/exerciseDatabaseController.dart';
import 'package:home_trainer/database/routineDatabaseController.dart';
import 'package:home_trainer/database/utilities/exercises.dart';

enum UnitInput { distance, intervals, restTime }

class SwimFormController extends StatefulWidget {
  @override
  _SwimFormControllerState createState() => _SwimFormControllerState();
}

class _SwimFormControllerState extends State<SwimFormController> {
  RoutineTextFormField _titleForm = new RoutineTextFormField(
    labelText: 'Routie title',
  );
  RoutineTextFormField _swimStyleForm = new RoutineTextFormField(
    labelText: 'Swim style',
  );

  List<ShortDistanceExercise> routine = <ShortDistanceExercise>[];

  // add new exercise to the routine
  bool addExercise() {
    if (_titleForm.formKey.currentState.validate()) {
      if (_swimStyleForm.formKey.currentState.validate()) {
        ShortDistanceExercise newRoutine = new ShortDistanceExercise(
          distance: distance.toString(),
          style: _swimStyleForm.controller.text.trim(),
          sessions: sessions.toString(),
          restTimeMin: restTimeMin.toString(),
          restTimeSec: restTimeSec.toString(),
        );
        routine.add(newRoutine);

        return true;
      }
    }
    return false;
  }

  Function increase(UnitInput input) {
    return () {
      setState(() {
        if (input == UnitInput.distance) {
          distance += 5;
        } else if (input == UnitInput.intervals) {
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
        if (input == UnitInput.distance && distance > 1) {
          distance -= 5;
        } else if (input == UnitInput.intervals && sessions > 1) {
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

  int sessions = 1;
  int swimSession = 1;
  int restTimeMin = 0;
  int restTimeSec = 0;
  int distance = 25;

  @override
  Widget build(BuildContext context) {
    final String sport = 'SWIM';

    return Column(
      children: <Widget>[
        // title text form filed
        Expanded(child: _titleForm),
        // swim style form field
        Expanded(child: _swimStyleForm),
        // distance and intervals unit inputs
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: UnitInputCard(
                  labelText: 'DISTANCE',
                  inputText: Text(
                    '${distance.toString()} m',
                    style: kTitleLabelTextStyle,
                  ),
                  cardColor: kActiveCardColor,
                  sizedBoxHeight: 20.0,
                  onPressedMinus: decrease(UnitInput.distance),
                  onPressedPlus: increase(UnitInput.distance),
                ),
              ),
              Expanded(
                child: UnitInputCard(
                  labelText: 'SESSIONS',
                  inputText:
                      Text(sessions.toString(), style: kTitleLabelTextStyle),
                  cardColor: kActiveCardColor,
                  sizedBoxHeight: 20.0,
                  onPressedMinus: decrease(UnitInput.intervals),
                  onPressedPlus: increase(UnitInput.intervals),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: UnitInputCard(
            labelText: 'REST TIME',
            inputText: Text(
                restTimeMin > 9
                    ? '$restTimeMin : $restTimeSec'
                    : '0$restTimeMin : $restTimeSec',
                style: kTitleLabelTextStyle),
            cardColor: kActiveCardColor,
            sizedBoxHeight: 20.0,
            onPressedMinus: decrease(UnitInput.restTime),
            onPressedPlus: increase(UnitInput.restTime),
          ),
        ),
        // add new exercise button
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: RoutineButton(
                  labelName: 'ADD NEW EXERCISE',
                  color: kButtonColor,
                  onPressed: () async {
                    if (addExercise()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Exercise added to routine')));
                    }
                  },
                ),
              ),
              // create routine button
              Expanded(
                child: RoutineButton(
                  labelName: 'CREATE ROUTINE',
                  color: kButtonColor,
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
                        ).createShortDistanceExerciseData(
                          exercise: 'swim session $swimSession',
                          distance: routine[i].distance,
                          style: routine[i].style,
                          sessions: routine[i].sessions,
                          restTimeMin: routine[i].restTimeMin,
                          restTimeSec: routine[i].restTimeSec,
                        );
                        swimSession++;
                      }

                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
