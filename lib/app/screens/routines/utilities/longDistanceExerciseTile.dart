import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/editLongDistanceExercisePage.dart';
import 'package:home_trainer/app/screens/routines/utilities/showAlertDialogMessage.dart';

class LongDistanceExerciseTile extends StatelessWidget {
  final String routine,
      exercise,
      distance,
      intervals,
      intensity,
      restTimeMin,
      restTimeSec,
      intensityTextLabel;
  LongDistanceExerciseTile({
    this.routine,
    this.exercise,
    this.distance,
    this.intervals,
    this.restTimeMin,
    this.restTimeSec,
    this.intensity,
    this.intensityTextLabel,
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
                        'Distance: $distance km',
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
                        builder: (context) => EditLongDistanceExercisePage(
                          routineTitle: routine,
                          exerciseTitle: exercise,
                          distance: distance,
                          intervals: intervals,
                          intensity: intensity,
                          restTimeMin: restTimeMin,
                          restTimeSec: restTimeSec,
                          intensityTextLabe: intensityTextLabel,
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
                        'Intervals: $intervals',
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
                        'Rest time: $restTimeMin : $restTimeSec',
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
          Container(
            height: 56.0,
            child: Card(
              color: Colors.blueGrey[400],
              child: Center(
                child: Text(
                  '$intensity',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
