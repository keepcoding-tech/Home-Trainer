import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseController {
  final String uid;
  UserDatabaseController({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future createUserData(String name, String email) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  Stream<QuerySnapshot> get userData {
    return usersCollection.snapshots();
  }
}
