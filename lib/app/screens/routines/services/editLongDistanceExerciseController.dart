import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:home_trainer/app/utilities/restTimeCard.dart';
import 'package:home_trainer/app/utilities/selectableCard.dart';
import 'package:home_trainer/app/utilities/unitInputCard.dart';
import 'package:home_trainer/database/exerciseDatabaseController.dart';

enum UnitInput { distance, intervals, minutes, seconds }
enum Intensity { easy, normal, intens }

class EditLongDistanceExerciseController extends StatefulWidget {
  final String routine,
      exercise,
      distance,
      intervals,
      intensity,
      restTimeMin,
      restTimeSec,
      intensityTextLabel;
  EditLongDistanceExerciseController({
    this.routine,
    this.exercise,
    this.distance,
    this.intervals,
    this.intensity,
    this.restTimeMin,
    this.restTimeSec,
    this.intensityTextLabel,
  });

  @override
  _EditLongDistanceExerciseControllerState createState() =>
      _EditLongDistanceExerciseControllerState(
        distance: double.parse(distance),
        intervals: int.parse(intervals),
        intensity: intensity,
        minutesLabelText: int.parse(restTimeMin),
        secondsLabelText: int.parse(restTimeSec),
      );
}

class _EditLongDistanceExerciseControllerState
    extends State<EditLongDistanceExerciseController> {
  double distance;
  int intervals;
  int runSession;
  String intensity;
  int minutesLabelText;
  int secondsLabelText;

  _EditLongDistanceExerciseControllerState({
    this.distance,
    this.intervals,
    this.intensity,
    this.minutesLabelText,
    this.secondsLabelText,
  });

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
          distance--;
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

  Intensity selectedGender = Intensity.normal;
  final Color activeColor = Colors.blueGrey[700];
  final Color inactiveColor = Colors.blueGrey[600];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: UnitInputCard(
                  labelText: 'DISTANCE',
                  inputText: Text(
                    '${distance.toString()} Km',
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
                  labelText: 'INTERVALS',
                  inputText: Text(
                    intervals.toString(),
                    style: kTitleLabelTextStyle,
                  ),
                  cardColor: kActiveCardColor,
                  sizedBoxHeight: 15.0,
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
          child: Row(
            children: [
              Expanded(
                child: SelectableCard(
                  cardChild: Center(
                    child: Text(
                      ' EASY\n  ${widget.intensityTextLabel}',
                      style: kSubtitleLabelTextStyle,
                    ),
                  ),
                  color: selectedGender == Intensity.easy
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  onPressed: () {
                    setState(() {
                      selectedGender = Intensity.easy;
                      intensity = 'EASY\n  ${widget.intensityTextLabel}';
                    });
                  },
                ),
              ),
              Expanded(
                child: SelectableCard(
                  cardChild: Center(
                    child: Text(
                      '  NORMAL\n     ${widget.intensityTextLabel}',
                      style: kSubtitleLabelTextStyle,
                    ),
                  ),
                  color: selectedGender == Intensity.normal
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  onPressed: () {
                    setState(() {
                      selectedGender = Intensity.normal;
                      intensity = 'NORMAL ${widget.intensityTextLabel}';
                    });
                  },
                ),
              ),
              Expanded(
                child: SelectableCard(
                  cardChild: Center(
                    child: Text(
                      ' INTENS\n    ${widget.intensityTextLabel}',
                      style: kSubtitleLabelTextStyle,
                    ),
                  ),
                  color: selectedGender == Intensity.intens
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  onPressed: () {
                    setState(() {
                      selectedGender = Intensity.intens;
                      intensity = 'INTENS ${widget.intensityTextLabel}';
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        // add new exercise button
        Expanded(
          child: RoutineButton(
            labelName: 'SAVE',
            color: kButtonColor,
            onPressed: () async {
              await ExerciseDatabaseController(
                routineTitle: widget.routine,
              ).createLongDistanceExerciseData(
                exercise: widget.exercise,
                distance: distance.toString(),
                intervals: intervals.toString(),
                restTimeMin: minutesLabelText.toString(),
                restTimeSec: secondsLabelText.toString(),
                intensity: intensity.toString(),
              );

              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
