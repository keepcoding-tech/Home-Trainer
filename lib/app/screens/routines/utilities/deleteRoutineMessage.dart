import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> deleteRoutienMessage(
    BuildContext context, String uid, String routineTitle) async {
  final CollectionReference _routineColection =
      FirebaseFirestore.instance.collection(uid);
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
              print(uid);
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
