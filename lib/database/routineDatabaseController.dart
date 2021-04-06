import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:home_trainer/database/utilities/routine.dart';

class RoutineDatabaseController {
  final _currentUser = FirebaseAuth.instance.currentUser;

  CollectionReference routineCollection() {
    final CollectionReference _routineCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser.uid)
        .collection('routines');

    return _routineCollection;
  }

  Future createRoutineData({String title, String sport}) async {
    return await routineCollection().doc(title).set({
      'title': title,
      'sport': sport,
    });
  }

  CollectionReference weekDaysCollection(String weekDay) {
    final CollectionReference _weekDaysCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser.uid)
        .collection('week days')
        .doc(weekDay)
        .collection(weekDay);

    return _weekDaysCollection;
  }

  Future createScheduleRoutine(
      {String weekDay, String routineTitle, String sport}) async {
    return await weekDaysCollection(weekDay).doc(routineTitle).set({
      'title': routineTitle,
      'sport': sport,
    });
  }

  List<Routine> _routinesList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Routine(
        title: doc.data()['title'] ?? '',
        sport: doc.data()['sport'] ?? '',
        isSelected: doc.data()['isSelected'] ?? false,
      );
    }).toList();
  }

  Stream<List<Routine>> get routine {
    return routineCollection().snapshots().map(_routinesList);
  }
}
