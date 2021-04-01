import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/editShortDistanceExercisePage.dart';
import 'package:home_trainer/app/screens/routines/utilities/showAlertDialogMessage.dart';

class ShortDistanceExerciseTile extends StatelessWidget {
  final String routineTitle,
      exerciseTitle,
      distance,
      style,
      sessions,
      restTimeMin,
      restTimeSec;
  ShortDistanceExerciseTile({
    this.routineTitle,
    this.exerciseTitle,
    this.distance,
    this.style,
    this.sessions,
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
                        'Distance: $distance m',
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
                        builder: (context) => EditShortDistanceExercisePage(
                          routineTitle: routineTitle,
                          exerciseTitle: exerciseTitle,
                          distance: distance,
                          style: style,
                          sessions: sessions,
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
                      messageTitle: 'Delete Routine',
                      messageDetails: 'Are you sure?',
                      onPressed: () {
                        _routineColection
                            .doc(_currentUser.uid)
                            .collection('routines')
                            .doc(routineTitle)
                            .collection('exercises')
                            .doc(exerciseTitle)
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
                        'Sessions: $sessions',
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
                  '$style',
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
