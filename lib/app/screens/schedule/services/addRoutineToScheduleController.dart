import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_trainer/database/routineDatabaseController.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/database/utilities/routine.dart';

class AddRoutineToScheduleController extends StatefulWidget {
  final String weekday;
  AddRoutineToScheduleController({this.weekday});

  @override
  _AddRoutineToScheduleControllerState createState() =>
      _AddRoutineToScheduleControllerState();
}

class _AddRoutineToScheduleControllerState
    extends State<AddRoutineToScheduleController> {
  @override
  Widget build(BuildContext context) {
    final routines = Provider.of<List<Routine>>(context) ?? [];

    final currentUser = FirebaseAuth.instance.currentUser;
    final List<String> _scheduledRoutines = <String>[];
    final _scheduledRoutinesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('weekdays')
        .doc(widget.weekday)
        .collection(widget.weekday);

    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ListView.builder(
              itemCount: routines.length,
              itemBuilder: (context, index) {
                return RoutineSelectableTile(
                  routine: routines[index],
                  weekday: widget.weekday,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: MaterialButton(
                color: Colors.blueGrey[600],
                child: Text('add routines'),
                onPressed: () async {
                  for (int i = 0; i < routines.length; i++) {
                    if (routines[i].isSelected) {
                      _scheduledRoutines.add(routines[i].title);
                      await RoutineDatabaseController().createScheduleRoutine(
                        weekDay: widget.weekday,
                        routineTitle: routines[i].title,
                        sport: routines[i].sport,
                      );
                    }
                  }
                  _scheduledRoutinesCollection.doc(widget.weekday).update({
                    'scheduledRoutines': _scheduledRoutines,
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoutineSelectableTile extends StatefulWidget {
  final Routine routine;
  final String weekday;
  RoutineSelectableTile({this.routine, this.weekday});

  @override
  _RoutineSelectableTileState createState() =>
      _RoutineSelectableTileState(routine: routine);
}

class _RoutineSelectableTileState extends State<RoutineSelectableTile> {
  final Routine routine;
  _RoutineSelectableTileState({this.routine});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[400],
      child: ListTile(
        title: Text(routine.title),
        subtitle: Text(routine.sport),
        trailing: Checkbox(
          value: routine.isSelected ?? false,
          onChanged: (value) {
            setState(() {
              routine.isSelected = !routine.isSelected;
            });
          },
        ),
      ),
    );
  }
}
