import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/app/screens/routines/utilities/unitInputCard.dart';
import 'package:home_trainer/database/exerciseDatabaseController.dart';

enum UnitInput { distance, intervals, restTime }

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
                  labelText: 'Distance',
                  inputText: Text(
                    distance.toString(),
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
                  labelText: 'Intervals',
                  inputText: Text(
                    intervals.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
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
          child: Row(
            children: [
              Expanded(
                child: RoutineButton(
                  labelName: 'EASY ${widget.intensityTextLabel}',
                  onPressed: () {
                    intensity = 'EASY ${widget.intensityTextLabel}';
                  },
                ),
              ),
              Expanded(
                child: RoutineButton(
                  labelName: 'NORMAL ${widget.intensityTextLabel}',
                  onPressed: () {
                    intensity = 'NORMAL ${widget.intensityTextLabel}';
                  },
                ),
              ),
              Expanded(
                child: RoutineButton(
                  labelName: 'INTENS ${widget.intensityTextLabel}',
                  onPressed: () {
                    intensity = 'INTENS ${widget.intensityTextLabel}';
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
              onPressed: () async {
                await ExerciseDatabaseController(
                  routineTitle: widget.routine,
                ).updateLongDistanceExerciseData(
                  exerciseTitle: widget.exercise,
                  distance: distance.toString(),
                  intervals: intervals.toString(),
                  restTimeMin: restTimeMin.toString(),
                  restTimeSec: restTimeSec.toString(),
                  intensity: intensity.toString(),
                );

                Navigator.pop(context);
              }),
        ),
      ],
    );
  }
}
