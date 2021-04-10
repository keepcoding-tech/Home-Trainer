import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/routineTextFormField.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:home_trainer/app/utilities/restTimeCard.dart';
import 'package:home_trainer/app/utilities/selectableCard.dart';
import 'package:home_trainer/app/utilities/unitInputCard.dart';
import 'package:home_trainer/database/exerciseDatabaseController.dart';
import 'package:home_trainer/database/routineDatabaseController.dart';
import 'package:home_trainer/database/utilities/exercises.dart';

enum UnitInput { distance, intervals, restTime, minutes, seconds }
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
        restTimeMin: minutesLabelText.toString(),
        restTimeSec: secondsLabelText.toString(),
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
          distance -= 0.5;
        } else if (input == UnitInput.intervals && intervals > 1) {
          intervals--;
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

  int minutesLabelText = 0, secondsLabelText = 0;
  int runSession = 1, intervals = 1;

  double distance = 0.0;
  String intensity = 'Normal run';

  Intensity selectedGender = Intensity.normal;

  @override
  Widget build(BuildContext context) {
    final String sport = 'CYCLING';

    return Column(
      children: <Widget>[
        // title text form filed
        _titleForm,
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
          child: RestTimeCard(
            labelText: 'REST TIME',
            cardColor: kActiveCardColor,
            sizedBoxHeight: 15.0,
            minutesLabelText: minutesLabelText,
            secondsLabelText: secondsLabelText,
            onPressedMinusMin: decrease(UnitInput.minutes),
            onPressedPlusMin: increase(UnitInput.minutes),
            onPressedMinusSec: decrease(UnitInput.seconds),
            onPressedPlusSec: increase(UnitInput.seconds),
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
                        SnackBar(
                          content: Text('Exercise added to routine'),
                        ),
                      );

                      setState(() {
                        minutesLabelText = 0;
                        secondsLabelText = 0;
                        runSession = 1;
                        intervals = 1;
                        distance = 0.0;
                        intensity = 'NORMAL RUN';
                        selectedGender = Intensity.normal;
                      });
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
