import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/routineTextFormField.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/app/screens/routines/utilities/unitInputCard.dart';
import 'package:home_trainer/database/exerciseDatabaseController.dart';
import 'package:home_trainer/database/routineDatabaseController.dart';
import 'package:home_trainer/database/utilities/exercises.dart';

enum UnitInput { sets, reps, weight, restTime }

class GymFormController extends StatefulWidget {
  @override
  _GymFormControllerState createState() => _GymFormControllerState();
}

class _GymFormControllerState extends State<GymFormController> {
  RoutineTextFormField _titleForm = new RoutineTextFormField(
    labelText: 'Routie title',
  );
  RoutineTextFormField _exerciseForm = new RoutineTextFormField(
    labelText: 'Exercise title',
  );
  RoutineTextFormField _muscleForm = new RoutineTextFormField(
    labelText: 'Muscle group',
  );

  List<StaticExercise> routine = <StaticExercise>[];

  // add new exercise to the routine
  bool addExercise() {
    if (_titleForm.formKey.currentState.validate()) {
      if (_exerciseForm.formKey.currentState.validate()) {
        if (_muscleForm.formKey.currentState.validate()) {
          StaticExercise newRoutine = new StaticExercise(
            exercise: _exerciseForm.controller.text.trim(),
            muscle: _muscleForm.controller.text.trim(),
            sets: sets.toString(),
            reps: reps.toString(),
            weight: weight.toString(),
            restTimeMin: restTimeMin.toString(),
            restTimeSec: restTimeSec.toString(),
          );
          routine.add(newRoutine);

          return true;
        }
      }
    }
    return false;
  }

  Function increase(UnitInput input) {
    return () {
      setState(() {
        if (input == UnitInput.sets) {
          sets++;
        } else if (input == UnitInput.reps) {
          reps++;
        } else if (input == UnitInput.weight) {
          weight += 0.5;
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
        if (input == UnitInput.sets && sets > 1) {
          sets--;
        } else if (input == UnitInput.reps && reps > 1) {
          reps--;
        } else if (input == UnitInput.weight && weight > 0) {
          weight -= 0.5;
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

  int sets = 1;
  int reps = 1;
  double weight = 0;
  int restTimeMin = 0;
  int restTimeSec = 0;

  @override
  Widget build(BuildContext context) {
    final String sport = 'GYM';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // title text form filed
        Expanded(child: _titleForm),
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
                  labelText: 'Sets',
                  inputText: Text(
                    sets.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressedMinus: decrease(UnitInput.sets),
                  onPressedPlus: increase(UnitInput.sets),
                ),
              ),
              Expanded(
                child: UnitInputCard(
                  labelText: 'Reps',
                  inputText: Text(
                    reps.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressedMinus: decrease(UnitInput.reps),
                  onPressedPlus: increase(UnitInput.reps),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              Expanded(
                child: UnitInputCard(
                  labelText: 'Weight',
                  inputText: Text(
                    weight.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressedMinus: decrease(UnitInput.weight),
                  onPressedPlus: increase(UnitInput.weight),
                ),
              ),
              Expanded(
                child: UnitInputCard(
                  labelText: 'Rest time',
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
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                // add new exercise button
                child: RoutineButton(
                  labelName: 'ADD NEW EXERCISE',
                  onPressed: () async {
                    if (addExercise()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Exercise added to routine')));

                      _exerciseForm.controller.clear();
                      _muscleForm.controller.clear();
                      sets = 1;
                      reps = 1;
                      weight = 0.0;
                      restTimeMin = 0;
                      restTimeSec = 0;
                    }
                  },
                ),
              ),
              Expanded(
                // create routine button
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
                        ).createStaticExerciseData(
                          exerciseTitle: routine[i].exercise,
                          muscle: routine[i].muscle,
                          sets: routine[i].sets,
                          reps: routine[i].reps,
                          weight: routine[i].weight,
                          restTimeMin: routine[i].restTimeMin,
                          restTimeSec: routine[i].restTimeSec,
                        );
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
