import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserName extends StatelessWidget {
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

class UserEmail extends StatelessWidget {
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
            data['email'],
            style: TextStyle(
              color: Colors.grey.shade200,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        return Text('');
      },
    );
  }
}
