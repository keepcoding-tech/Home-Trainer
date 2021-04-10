import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/utilities/constantsStyles.dart';
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
        .collection('scheduledRoutines');

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
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RawMaterialButton(
              constraints: BoxConstraints.tightFor(
                height: 75.0,
                width: double.infinity,
              ),
              fillColor: kButtonColor,
              child: Text(
                '+ADD ROUTINE',
                style: kButtonLabelTextStyle,
              ),
              onPressed: () async {
                for (int i = 0; i < routines.length; i++) {
                  if (routines[i].isSelected) {
                    _scheduledRoutines.add(routines[i].title);
                  }
                }
                _scheduledRoutinesCollection.doc(widget.weekday).update({
                  'scheduledRoutines': _scheduledRoutines,
                });
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RoutineSelectableTile extends StatefulWidget {
  final Routine routine;
  RoutineSelectableTile({this.routine});

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
      color: kActiveCardColor,
      child: ListTile(
        title: Text(
          routine.title,
          style: kTitleLabelTextStyle,
        ),
        subtitle: Text(
          routine.sport,
          style: kSubtitleLabelTextStyle,
        ),
        trailing: Transform.scale(
          scale: 2.0,
          child: Checkbox(
            activeColor: kButtonColor,
            value: routine.isSelected ?? false,
            onChanged: (value) {
              setState(() {
                routine.isSelected = !routine.isSelected;
              });
            },
          ),
        ),
      ),
    );
  }
}
