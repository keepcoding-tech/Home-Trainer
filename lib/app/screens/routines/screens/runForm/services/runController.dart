import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/routineTextFormField.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/app/screens/routines/utilities/unitInputCard.dart';
import 'package:home_trainer/database/exerciseDatabaseController.dart';
import 'package:home_trainer/database/routineDatabaseController.dart';
import 'package:home_trainer/database/utilities/exercises.dart';

enum UnitInput { distance, intervals, restTime }

class RunFormController extends StatefulWidget {
  @override
  _RunFormControllerState createState() => _RunFormControllerState();
}

class _RunFormControllerState extends State<RunFormController> {
  RoutineTextFormField _titleForm = new RoutineTextFormField(
    labelText: 'Routie title',
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
  String intensity = 'NORMAL RUN';

  @override
  Widget build(BuildContext context) {
    final String sport = 'RUN';

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
                  labelText: 'Distance:',
                  inputText: Text(
                    distance.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
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
                      fontSize: 20.0,
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
            labelText: 'Rest time:',
            inputText: Text(
              restTimeMin > 9
                  ? '$restTimeMin : $restTimeSec'
                  : '0$restTimeMin : $restTimeSec',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
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
                  labelName: 'EASY RUN',
                  onPressed: () {
                    intensity = 'EASY RUN';
                  },
                ),
              ),
              Expanded(
                child: RoutineButton(
                  labelName: 'NORMAL RUN',
                  onPressed: () {
                    intensity = 'NORMAL RUN';
                  },
                ),
              ),
              Expanded(
                child: RoutineButton(
                  labelName: 'INTENSE RUN',
                  onPressed: () {
                    intensity = 'INTENSE RUN';
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
                          exerciseTitle: 'run session $runSession',
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
