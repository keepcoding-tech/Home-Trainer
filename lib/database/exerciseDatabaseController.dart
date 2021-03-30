import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExerciseDatabaseController {
  final String routineTitle;
  ExerciseDatabaseController({this.routineTitle});

  CollectionReference exerciseCollection() {
    final _currentUser = FirebaseAuth.instance.currentUser;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser.uid)
        .collection('routines')
        .doc(routineTitle)
        .collection('exercises');
  }

  Future createExerciseData({
    String exerciseTitle,
    String muscle,
    String sets,
    String reps,
    String weight,
  }) async {
    return await exerciseCollection().doc(exerciseTitle).set({
      'exercise': exerciseTitle,
      'muscle': muscle,
      'sets': sets,
      'reps': reps,
      'weight': weight,
    });
  }

  Future updateGymExerciseData({
    String exercise,
    String muscle,
    String sets,
    String reps,
    String weight,
  }) async {
    return await exerciseCollection().doc(exercise).set({
      'exercise': exercise,
      'muscle': muscle,
      'sets': sets,
      'reps': reps,
      'weight': weight,
    });
  }
}
