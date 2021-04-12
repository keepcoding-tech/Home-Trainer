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

  // Create a new gym exercise
  Future createStaticExerciseData({
    String exercise,
    String muscle,
    String sets,
    String reps,
    String weight,
    String restTimeMin,
    String restTimeSec,
  }) async {
    return await exerciseCollection().doc(exercise).set({
      'exercise': exercise,
      'muscle': muscle,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'restTimeMin': restTimeMin,
      'restTimeSec': restTimeSec,
    });
  }

  // Create a new long distance exercise
  Future createLongDistanceExerciseData({
    String exercise,
    String distance,
    String intervals,
    String intensity,
    String restTimeMin,
    String restTimeSec,
  }) async {
    return await exerciseCollection().doc(exercise).set({
      'exercise': exercise,
      'distance': distance,
      'intervals': intervals,
      'intensity': intensity,
      'restTimeMin': restTimeMin,
      'restTimeSec': restTimeSec,
    });
  }

  // Create a new short distance exercise
  Future createShortDistanceExerciseData({
    String exercise,
    String distance,
    String sessions,
    String style,
    String restTimeMin,
    String restTimeSec,
  }) async {
    return await exerciseCollection().doc(exercise).set({
      'exercise': exercise,
      'distance': distance,
      'sessions': sessions,
      'style': style,
      'restTimeMin': restTimeMin,
      'restTimeSec': restTimeSec,
    });
  }
}
