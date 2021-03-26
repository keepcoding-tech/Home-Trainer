import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final User _currentUser = FirebaseAuth.instance.currentUser;
final CollectionReference _routineColection =
    FirebaseFirestore.instance.collection(_currentUser.uid);

Future<void> deleteRoutienMessage(
    BuildContext context, String routineTitle) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete routien'),
        content: Text(
          'Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              _currentUser.reload();
              print(_currentUser.uid);
              _routineColection.doc(routineTitle).delete();
              Navigator.of(context).pop();
            },
            child: Text('YES'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('NO'),
          ),
        ],
      );
    },
  );
}
