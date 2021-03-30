import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/exerciseTile.dart';

class DetailPageList extends StatefulWidget {
  final String routineTitle;
  DetailPageList({this.routineTitle});

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
              return ExerciseTile(
                routine: widget.routineTitle,
                exercise: snapshot.data.docs[index].data()['exercise'],
                muscle: snapshot.data.docs[index].data()['muscle'],
                sets: snapshot.data.docs[index].data()['sets'],
                reps: snapshot.data.docs[index].data()['reps'],
                weight: snapshot.data.docs[index].data()['weight'],
              );
            },
          );
        },
      ),
    );
  }
}
