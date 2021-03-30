import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/editTextFormField.dart';
import 'package:home_trainer/database/exerciseDatabaseController.dart';

class EditExerciseController extends StatefulWidget {
  final String routineTitle, exerciseTitle, muscle, sets, reps, weight;
  EditExerciseController({
    this.routineTitle,
    this.exerciseTitle,
    this.muscle,
    this.sets,
    this.reps,
    this.weight,
  });

  @override
  _EditExerciseControllerState createState() => _EditExerciseControllerState();
}

class _EditExerciseControllerState extends State<EditExerciseController> {
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
    EditTextFormField _setsForm = EditTextFormField(
      labelText: 'sets',
      defaultData: widget.sets,
    );
    EditTextFormField _repsForm = EditTextFormField(
      labelText: 'reps',
      defaultData: widget.reps,
    );
    EditTextFormField _weightForm = EditTextFormField(
      labelText: 'weight',
      defaultData: widget.weight,
    );

    return Column(
      children: <Widget>[
        // exercise text form field
        _exerciseForm,
        // muscle text form field
        _muscleForm,
        // sets, reps and weight fields
        Container(
          margin: EdgeInsets.all(10.0),
          color: Colors.blueGrey[600],
          child: Row(
            children: <Widget>[
              Expanded(child: _setsForm),
              Expanded(child: _repsForm),
              Expanded(child: _weightForm),
            ],
          ),
        ),
        MaterialButton(
          color: Colors.white,
          child: Text('SAVE'),
          onPressed: () async {
            if (_exerciseForm.formKey.currentState.validate()) {
              if (_muscleForm.formKey.currentState.validate()) {
                if (_setsForm.formKey.currentState.validate()) {
                  if (_repsForm.formKey.currentState.validate()) {
                    if (_weightForm.formKey.currentState.validate()) {
                      _routineColection
                          .doc(_currentUser.uid)
                          .collection('routines')
                          .doc(widget.routineTitle)
                          .collection('exercises')
                          .doc(widget.exerciseTitle)
                          .delete();

                      await ExerciseDatabaseController(
                        routineTitle: widget.routineTitle,
                      ).updateGymExerciseData(
                        exercise: _exerciseForm.controller.text.trim(),
                        muscle: _muscleForm.controller.text.trim(),
                        sets: _setsForm.controller.text.trim(),
                        reps: _repsForm.controller.text.trim(),
                        weight: _weightForm.controller.text.trim(),
                      );

                      Navigator.pop(context);
                    }
                  }
                }
              }
            }
          },
        ),
      ],
    );
  }
}
