import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/schedule/screens/monday/utilities/scheduledRoutineTitle.dart';
import 'package:home_trainer/app/screens/routines/utilities/longDistanceExerciseTile.dart';
import 'package:home_trainer/app/screens/routines/utilities/shortDistanceExerciseTile.dart';
import 'package:home_trainer/app/screens/routines/utilities/staticExerciseTile.dart';
import 'package:home_trainer/app/services/loadingScreen.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class ScheduledRoutinesController extends StatefulWidget {
  final String weekday;
  ScheduledRoutinesController({this.weekday});

  @override
  _ScheduledRoutinesControllerState createState() =>
      _ScheduledRoutinesControllerState();
}

class _ScheduledRoutinesControllerState
    extends State<ScheduledRoutinesController> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CollectionReference scheduledRoutinesData = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('scheduledRoutines');

    return FutureBuilder<DocumentSnapshot>(
      future: scheduledRoutinesData.doc(widget.weekday).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          CollectionReference scheduledRoutinesStreamData = FirebaseFirestore
              .instance
              .collection('users')
              .doc(currentUser.uid)
              .collection('routines');

          return StreamBuilder<QuerySnapshot>(
            stream: scheduledRoutinesStreamData.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('loading . . .');
              }

              List<dynamic> scheduledRoutineList = data['scheduledRoutines'];
              List<String> scheduledRoutinesSport = <String>[];
              for (int i = 0; i < scheduledRoutineList.length; i++) {
                for (int j = 0; j < snapshot.data.docs.length; j++) {
                  if (snapshot.data.docs[j].data()['title'] ==
                      scheduledRoutineList[i]) {
                    scheduledRoutinesSport
                        .add(snapshot.data.docs[j].data()['sport']);
                    break;
                  }
                }
              }

              return ListView.builder(
                itemCount: scheduledRoutineList.length,
                itemBuilder: (context, index) {
                  return ScheduledRoutines(
                    routineTitle: scheduledRoutineList[index],
                    routineSport: scheduledRoutinesSport[index],
                  );
                },
              );
            },
          );
        }

        return LoadingAnimation(loadingSize: 50.0);
      },
    );
  }
}

class ScheduledRoutines extends StatelessWidget {
  ScheduledRoutines({this.routineTitle, this.routineSport});
  final String routineTitle, routineSport;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final routineData = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('routines')
        .doc(routineTitle)
        .collection('exercises');

    return Column(
      children: [
        ScheduledRoutineTitle(routineTitle: routineTitle),
        StreamBuilder(
          stream: routineData.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('');
            }

            return Container(
              height: routineSport == 'RUN' ||
                      routineSport == 'CYCLING' ||
                      routineSport == 'SWIM'
                  ? 195 * snapshot.data.docs.length.toDouble()
                  : 250 * snapshot.data.docs.length.toDouble(),
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: kActiveCardColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  if (routineSport == 'RUN' || routineSport == 'CYCLING') {
                    return LongDistanceExerciseTile(
                      isModifiable: false,
                      routine: routineTitle,
                      exercise: snapshot.data.docs[index].data()['exercise'],
                      distance: snapshot.data.docs[index].data()['distance'],
                      intervals: snapshot.data.docs[index].data()['intervals'],
                      restTimeMin:
                          snapshot.data.docs[index].data()['restTimeMin'],
                      restTimeSec:
                          snapshot.data.docs[index].data()['restTimeSec'],
                      intensity: snapshot.data.docs[index].data()['intensity'],
                      intensityTextLabel: routineSport,
                    );
                  } else if (routineSport == 'SWIM') {
                    return ShortDistanceExerciseTile(
                      isModifiable: false,
                      routine: routineTitle,
                      exerciseTitle:
                          snapshot.data.docs[index].data()['exercise'],
                      distance: snapshot.data.docs[index].data()['distance'],
                      style: snapshot.data.docs[index].data()['style'],
                      sessions: snapshot.data.docs[index].data()['sessions'],
                      restTimeMin:
                          snapshot.data.docs[index].data()['restTimeMin'],
                      restTimeSec:
                          snapshot.data.docs[index].data()['restTimeSec'],
                    );
                  } else {
                    return StaticExerciseTile(
                      isModifiable: false,
                      routine: routineTitle,
                      exercise: snapshot.data.docs[index].data()['exercise'],
                      muscle: snapshot.data.docs[index].data()['muscle'],
                      sets: snapshot.data.docs[index].data()['sets'],
                      reps: snapshot.data.docs[index].data()['reps'],
                      weight: snapshot.data.docs[index].data()['weight'],
                      restTimeMin:
                          snapshot.data.docs[index].data()['restTimeMin'],
                      restTimeSec:
                          snapshot.data.docs[index].data()['restTimeSec'],
                    );
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
