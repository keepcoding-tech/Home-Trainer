import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseController {
  final String uid;
  UserDatabaseController({this.uid});

  Future updateUserData(String name, String email) async {
    final CollectionReference usersColection =
        FirebaseFirestore.instance.collection(uid);

    return await usersColection.doc('user data').set({
      'name': name,
      'email': email,
      'title': 'user data',
    });
  }
}
