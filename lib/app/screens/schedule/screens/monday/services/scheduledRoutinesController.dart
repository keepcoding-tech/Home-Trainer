import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/longDistanceExerciseTile.dart';

class ScheduledRoutinesController extends StatefulWidget {
  final String weekday;
  ScheduledRoutinesController({this.weekday});

  @override
  _ScheduledRoutinesControllerState createState() =>
      _ScheduledRoutinesControllerState();
}

class _ScheduledRoutinesControllerState
    extends State<ScheduledRoutinesController> {
  @override
  Widget build(BuildContext context) {
    final _currentUser = FirebaseAuth.instance.currentUser;
    List<Widget> routineList = <Widget>[];
    CollectionReference scheduledRoutinesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser.uid)
        .collection('weekdays');

    return FutureBuilder<DocumentSnapshot>(
      future: scheduledRoutinesCollection.doc(widget.weekday).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          List<dynamic> scheduledRoutinesList = data['scheduledRoutines'];
          for (int index = 0; index < scheduledRoutinesList.length; index++) {
            routineList.add(ScheduledRoutines(
                scheduledRoutine: scheduledRoutinesList[index]));
          }
          return ListView(
            children: routineList,
          );
        }

        return Text("loading");
      },
    );
  }
}

class ScheduledRoutines extends StatelessWidget {
  ScheduledRoutines({this.scheduledRoutine});
  final String scheduledRoutine;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final _scheduledRoutinesData = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('routines')
        .doc(scheduledRoutine)
        .collection('exercises');

    return StreamBuilder<QuerySnapshot>(
      stream: _scheduledRoutinesData.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('loading . . .');
        }

        return LongDistanceExerciseTile(
          routine: snapshot.data.docs[0].data()['title'],
          exercise: snapshot.data.docs[0].data()['exercise'],
          distance: snapshot.data.docs[0].data()['distance'],
          intervals: snapshot.data.docs[0].data()['intervals'],
          restTimeMin: snapshot.data.docs[0].data()['restTimeMin'],
          restTimeSec: snapshot.data.docs[0].data()['restTimeSec'],
          intensity: snapshot.data.docs[0].data()['intensity'],
          intensityTextLabel: snapshot.data.docs[0].data()['sport'],
        );

        // return ListView.builder(
        //   itemBuilder: (context, index) {
        //     return LongDistanceExerciseTile(
        //       routine: snapshot.data.docs[index].data()['title'],
        //       exercise: snapshot.data.docs[index].data()['exercise'],
        //       distance: snapshot.data.docs[index].data()['distance'],
        //       intervals: snapshot.data.docs[index].data()['intervals'],
        //       restTimeMin: snapshot.data.docs[index].data()['restTimeMin'],
        //       restTimeSec: snapshot.data.docs[index].data()['restTimeSec'],
        //       intensity: snapshot.data.docs[index].data()['intensity'],
        //       intensityTextLabel: snapshot.data.docs[index].data()['sport'],
        //     );
        //   },
        // );
      },
    );
  }
}

// if (snapshot.data.docs[0].data()['sport'] == 'RUN' ||
//     snapshot.data.docs[0].data()['sport'] == 'CYCLING') {
// } else if (snapshot.data.docs[0].data()['sport'] == 'SWIM') {
//   return ShortDistanceExerciseTile(
//     routine: snapshot.data.docs[0].data()['title'],
//     exerciseTitle: snapshot.data.docs[0].data()['exercise'],
//     distance: snapshot.data.docs[0].data()['distance'],
//     style: snapshot.data.docs[0].data()['style'],
//     sessions: snapshot.data.docs[0].data()['sessions'],
//     restTimeMin: snapshot.data.docs[0].data()['restTimeMin'],
//     restTimeSec: snapshot.data.docs[0].data()['restTimeSec'],
//   );
// } else {
//   return StaticExerciseTile(
//     routine: snapshot.data.docs[0].data()['title'],
//     exercise: snapshot.data.docs[0].data()['exercise'],
//     muscle: snapshot.data.docs[0].data()['muscle'],
//     sets: snapshot.data.docs[0].data()['sets'],
//     reps: snapshot.data.docs[0].data()['reps'],
//     weight: snapshot.data.docs[0].data()['weight'],
//     restTimeMin: snapshot.data.docs[0].data()['restTimeMin'],
//     restTimeSec: snapshot.data.docs[0].data()['restTimeSec'],
//   );
// }
