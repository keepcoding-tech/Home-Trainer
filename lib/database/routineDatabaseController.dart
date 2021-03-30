import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:home_trainer/database/utilities/routine.dart';

class RoutineDatabaseController {
  CollectionReference routineCollection() {
    final _currentUser = FirebaseAuth.instance.currentUser;

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

  List<Routine> _routinesList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Routine(
        title: doc.data()['title'] ?? '',
        sport: doc.data()['sport'] ?? '',
      );
    }).toList();
  }

  Stream<List<Routine>> get routine {
    return routineCollection().snapshots().map(_routinesList);
  }
}
