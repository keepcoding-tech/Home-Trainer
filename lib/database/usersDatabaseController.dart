import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseController {
  final String uid;
  UserDatabaseController({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future createWeekDaysDatabase() async {
    List<String> scheduledRoutines = <String>[];
    List<String> weekDays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    for (int i = 0; i < weekDays.length; i++) {
      await usersCollection
          .doc(uid)
          .collection('weekdays')
          .doc(weekDays[i])
          .set({
        'title': weekDays[i],
        'scheduledRoutines': scheduledRoutines,
      });
    }
  }

  Future createUserData({
    String email,
    String name,
    String gender,
    String height,
    String weight,
    String age,
    List<double> analyticData,
  }) async {
    createWeekDaysDatabase();
    return await usersCollection.doc(uid).set({
      'email': email,
      'name': name,
      'gender': gender,
      'height': height,
      'weight': weight,
      'age': age,
      'analyticData': analyticData,
    });
  }

  Future updateUserInfoData(
      String gender, String height, String weight, String age) async {
    return await usersCollection.doc(uid).update({
      'gender': gender,
      'height': height,
      'weight': weight,
      'age': age,
    });
  }

  Future updateUserInfoGeneticsData(double analyticData) async {
    return await usersCollection.doc(uid).update({
      'analyticData': FieldValue.arrayUnion([analyticData]),
    });
  }

  Future deleteUserInfoGeneticsData(List<dynamic> analyticData) async {
    return await usersCollection.doc(uid).update({
      'analyticData': analyticData,
    });
  }

  Stream<QuerySnapshot> get userData {
    return usersCollection.snapshots();
  }
}
