import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:home_trainer/app/utilities/selectableCard.dart';
import 'package:home_trainer/app/utilities/unitInputCard.dart';
import 'package:home_trainer/database/exerciseDatabaseController.dart';

enum UnitInput { distance, intervals, restTime }
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
        restTimeMin: int.parse(restTimeMin),
        restTimeSec: int.parse(restTimeSec),
      );
}

class _EditLongDistanceExerciseControllerState
    extends State<EditLongDistanceExerciseController> {
  double distance;
  int intervals;
  int runSession;
  String intensity;
  int restTimeMin;
  int restTimeSec;

  _EditLongDistanceExerciseControllerState({
    this.distance,
    this.intervals,
    this.intensity,
    this.restTimeMin,
    this.restTimeSec,
  });

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
          distance--;
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
                    distance.toString(),
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
          child: UnitInputCard(
            labelText: 'REST TIME',
            inputText: Text(
              restTimeMin > 9
                  ? '$restTimeMin : $restTimeSec'
                  : '0$restTimeMin : $restTimeSec',
              style: kTitleLabelTextStyle,
            ),
            cardColor: kActiveCardColor,
            sizedBoxHeight: 15.0,
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
                restTimeMin: restTimeMin.toString(),
                restTimeSec: restTimeSec.toString(),
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
