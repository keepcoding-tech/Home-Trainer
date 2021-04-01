import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/longDistanceExerciseTile.dart';
import 'package:home_trainer/app/screens/routines/utilities/shortDistanceExerciseTile.dart';
import 'package:home_trainer/app/screens/routines/utilities/staticExerciseTile.dart';

class DetailPageList extends StatefulWidget {
  final String routineTitle, sport;
  DetailPageList({this.routineTitle, this.sport});

  @override
  _DetailPageListState createState() => _DetailPageListState();
}

class _DetailPageListState extends State<DetailPageList> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final routineData = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('routines')
        .doc(widget.routineTitle)
        .collection('exercises');

    return Container(
      child: StreamBuilder(
        stream: routineData.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('loading . . .');
          }

          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              if (widget.sport == 'RUN' || widget.sport == 'CYCLING') {
                return LongDistanceExerciseTile(
                  routine: widget.routineTitle,
                  exercise: snapshot.data.docs[index].data()['exercise'],
                  distance: snapshot.data.docs[index].data()['distance'],
                  intervals: snapshot.data.docs[index].data()['intervals'],
                  restTimeMin: snapshot.data.docs[index].data()['restTimeMin'],
                  restTimeSec: snapshot.data.docs[index].data()['restTimeSec'],
                  intensity: snapshot.data.docs[index].data()['intensity'],
                  intensityTextLabel: widget.sport,
                );
              } else if (widget.sport == 'SWIM') {
                return ShortDistanceExerciseTile(
                  routineTitle: widget.routineTitle,
                  exerciseTitle: snapshot.data.docs[index].data()['exercise'],
                  distance: snapshot.data.docs[index].data()['distance'],
                  style: snapshot.data.docs[index].data()['style'],
                  sessions: snapshot.data.docs[index].data()['sessions'],
                  restTimeMin: snapshot.data.docs[index].data()['restTimeMin'],
                  restTimeSec: snapshot.data.docs[index].data()['restTimeSec'],
                );
              } else {
                return StaticExerciseTile(
                  routine: widget.routineTitle,
                  exercise: snapshot.data.docs[index].data()['exercise'],
                  muscle: snapshot.data.docs[index].data()['muscle'],
                  sets: snapshot.data.docs[index].data()['sets'],
                  reps: snapshot.data.docs[index].data()['reps'],
                  weight: snapshot.data.docs[index].data()['weight'],
                  restTimeMin: snapshot.data.docs[index].data()['restTimeMin'],
                  restTimeSec: snapshot.data.docs[index].data()['restTimeSec'],
                );
              }
            },
          );
        },
      ),
    );
  }
}
