import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/editStaticExercisePage.dart';
import 'package:home_trainer/app/screens/routines/utilities/showAlertDialogMessage.dart';

class StaticExerciseTile extends StatelessWidget {
  final String routine,
      exercise,
      muscle,
      sets,
      reps,
      weight,
      restTimeMin,
      restTimeSec;
  StaticExerciseTile({
    this.routine,
    this.exercise,
    this.muscle,
    this.sets,
    this.reps,
    this.weight,
    this.restTimeMin,
    this.restTimeSec,
  });

  final _currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference _routineColection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      color: Colors.blueGrey[600],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 56.0,
                  child: Card(
                    color: Colors.blueGrey[400],
                    child: Center(
                      child: Text(
                        'Muscle: $muscle',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.blueGrey[400],
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditStaticExercisePage(
                          routineTitle: routine,
                          exerciseTitle: exercise,
                          muscle: muscle,
                          sets: sets,
                          reps: reps,
                          weight: weight,
                          restTimeMin: restTimeMin,
                          restTimeSec: restTimeSec,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Card(
                color: Colors.blueGrey[400],
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showAlertDialogMessage(
                      context: context,
                      messageTitle: 'Delete Exercise',
                      messageDetails:
                          'Are you sure you want to delate the exercise?',
                      onPressed: () {
                        _routineColection
                            .doc(_currentUser.uid)
                            .collection('routines')
                            .doc(routine)
                            .collection('exercises')
                            .doc(exercise)
                            .delete();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Container(
            height: 56.0,
            child: Card(
              color: Colors.blueGrey[400],
              child: Center(
                child: Text(
                  'Exercise: $exercise',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 56.0,
                  child: Card(
                    color: Colors.blueGrey[400],
                    child: Center(
                      child: Text(
                        'Sets: $sets',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 56.0,
                  child: Card(
                    color: Colors.blueGrey[400],
                    child: Center(
                      child: Text(
                        'Reps: $reps',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 56.0,
                  child: Card(
                    color: Colors.blueGrey[400],
                    child: Center(
                      child: Text(
                        'Weight: $weight',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 56.0,
                  child: Card(
                    color: Colors.blueGrey[400],
                    child: Center(
                      child: Text(
                        'Rest: $restTimeMin : $restTimeSec',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
