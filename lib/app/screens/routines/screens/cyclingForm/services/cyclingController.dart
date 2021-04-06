import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/routineTextFormField.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:home_trainer/app/utilities/selectableCard.dart';
import 'package:home_trainer/app/utilities/unitInputCard.dart';
import 'package:home_trainer/database/exerciseDatabaseController.dart';
import 'package:home_trainer/database/routineDatabaseController.dart';
import 'package:home_trainer/database/utilities/exercises.dart';

enum UnitInput { distance, intervals, restTime }
enum Intensity { easy, normal, intens }

class CyclingFormController extends StatefulWidget {
  @override
  _CyclingFormControllerState createState() => _CyclingFormControllerState();
}

class _CyclingFormControllerState extends State<CyclingFormController> {
  RoutineTextFormField _titleForm = new RoutineTextFormField(
    labelText: 'Routine title',
  );

  List<LongDistanceExercise> routine = <LongDistanceExercise>[];

  // add new exercise to the routine
  bool addExercise() {
    if (_titleForm.formKey.currentState.validate()) {
      LongDistanceExercise newRoutine = new LongDistanceExercise(
        distance: distance.toString(),
        intervals: intervals.toString(),
        intensity: intensity,
        restTimeMin: restTimeMin.toString(),
        restTimeSec: restTimeSec.toString(),
      );
      routine.add(newRoutine);

      return true;
    }
    return false;
  }

  Function increase(UnitInput input) {
    return () {
      setState(() {
        if (input == UnitInput.distance) {
          distance += 0.5;
        } else if (input == UnitInput.intervals) {
          intervals++;
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
          distance -= 0.5;
        } else if (input == UnitInput.intervals && intervals > 1) {
          intervals--;
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

  int intervals = 1;
  int runSession = 1;
  int restTimeMin = 0;
  int restTimeSec = 0;

  double distance = 0.0;
  String intensity = 'Normal run';

  Intensity selectedGender = Intensity.normal;

  @override
  Widget build(BuildContext context) {
    final String sport = 'CYCLING';

    return Column(
      children: <Widget>[
        // title text form filed
        Expanded(child: _titleForm),
        // distance and intervals unit inputs
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: UnitInputCard(
                  labelText: 'DISTANCE',
                  inputText:
                      Text(distance.toString(), style: kTitleLabelTextStyle),
                  cardColor: kActiveCardColor,
                  sizedBoxHeight: 20.0,
                  onPressedMinus: decrease(UnitInput.distance),
                  onPressedPlus: increase(UnitInput.distance),
                ),
              ),
              Expanded(
                child: UnitInputCard(
                  labelText: 'INTERVALS',
                  inputText:
                      Text(intervals.toString(), style: kTitleLabelTextStyle),
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
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: SelectableCard(
                  cardChild: Center(
                    child: Text(
                      '   EASY\nCYCLING',
                      style: kSubtitleLabelTextStyle,
                    ),
                  ),
                  color: selectedGender == Intensity.easy
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  onPressed: () {
                    setState(() {
                      selectedGender = Intensity.easy;
                      intensity = 'EASY CYCLING';
                    });
                  },
                ),
              ),
              Expanded(
                child: SelectableCard(
                  cardChild: Center(
                    child: Text(
                      ' NORMAL\n CYCLING',
                      style: kSubtitleLabelTextStyle,
                    ),
                  ),
                  color: selectedGender == Intensity.normal
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  onPressed: () {
                    setState(() {
                      selectedGender = Intensity.normal;
                      intensity = 'NORMAL CYCLING';
                    });
                  },
                ),
              ),
              Expanded(
                child: SelectableCard(
                  cardChild: Center(
                    child: Text(
                      ' INTENSE\n CYCLING',
                      style: kSubtitleLabelTextStyle,
                    ),
                  ),
                  color: selectedGender == Intensity.intens
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  onPressed: () {
                    setState(() {
                      selectedGender = Intensity.intens;
                      intensity = 'INTENSE CYCLING';
                    });
                  },
                ),
              ),
            ],
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
                        ).createLongDistanceExerciseData(
                          exercise: 'cycling session $runSession',
                          distance: routine[i].distance.toString(),
                          intervals: routine[i].intervals.toString(),
                          restTimeMin: routine[i].restTimeMin,
                          restTimeSec: routine[i].restTimeSec,
                          intensity: routine[i].intensity,
                        );
                        runSession++;
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
