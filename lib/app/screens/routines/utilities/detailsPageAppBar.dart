import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/deleteRoutineMessage.dart';

class DetailsPageAppBar extends StatelessWidget {
  const DetailsPageAppBar({this.routineTitle});
  final String routineTitle;

  @override
  Widget build(BuildContext context) {
    final _currentUser = FirebaseAuth.instance.currentUser;
    final CollectionReference _routineColection =
        FirebaseFirestore.instance.collection('users');

    return AppBar(
      title: Text(routineTitle),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: <Widget>[
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
                    .doc(routineTitle)
                    .collection('exercises')
                    .get()
                    .then((snapshot) {
                  for (DocumentSnapshot ds in snapshot.docs) {
                    ds.reference.delete();
                  }
                });

                _routineColection
                    .doc(_currentUser.uid)
                    .collection('routines')
                    .doc(routineTitle)
                    .delete();

                Navigator.pop(context);
              },
            );
          },
        ),
      ],
    );
  }
}
