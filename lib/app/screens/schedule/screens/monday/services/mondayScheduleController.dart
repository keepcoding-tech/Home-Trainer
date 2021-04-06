import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MondayScheduleController extends StatefulWidget {
  final String weekday;
  MondayScheduleController({this.weekday});

  @override
  _MondayScheduleControllerState createState() =>
      _MondayScheduleControllerState();
}

class _MondayScheduleControllerState extends State<MondayScheduleController> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final _scheduledRoutinesData = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('routines')
        .doc('test 1')
        .collection('exercises');

    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: StreamBuilder(
                stream: _scheduledRoutinesData.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('loading . . .');
                  }

                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return ScheduledRoutinesData();
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduledRoutinesData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference user = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(_currentUser.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text(
            data['name'],
            style: TextStyle(
              color: Colors.grey.shade200,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        return Text('');
      },
    );
  }
}
