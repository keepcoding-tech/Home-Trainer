import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/editExercisePage.dart';
import 'package:home_trainer/app/screens/routines/utilities/deleteRoutineMessage.dart';

class ExerciseTile extends StatelessWidget {
  final String routine, exercise, muscle, sets, reps, weight;
  ExerciseTile({
    this.routine,
    this.exercise,
    this.muscle,
    this.sets,
    this.reps,
    this.weight,
  });

  final _currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference _routineColection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            color: Colors.blueGrey[600],
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditExercisePage(
                              routineTitle: routine,
                              exerciseTitle: exercise,
                              muscle: muscle,
                              sets: sets,
                              reps: reps,
                              weight: weight,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showAlertDialogMessage(
                          context: context,
                          messageTitle: 'Delete Routine',
                          messageDetails: 'Are you sure?',
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
                  ],
                ),
                Card(
                  color: Colors.blueGrey[400],
                  child: ListTile(
                    title: Text(
                      exercise,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.blueGrey[400],
                  child: ListTile(
                      title: Text(
                    muscle,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          color: Colors.blueGrey[400],
                          child: Column(
                            children: [
                              Text('SETS'),
                              Text(sets),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: Colors.blueGrey[400],
                          child: Column(
                            children: [
                              Text('REPS'),
                              Text(reps),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: Colors.blueGrey[400],
                          child: Column(
                            children: [
                              Text('WEIGHT'),
                              Text(weight),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
