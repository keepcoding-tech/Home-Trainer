import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/authentication/services/createUserInfoData.dart';
import 'package:home_trainer/app/services/navigationController.dart';
import 'package:home_trainer/authentication/screens/signIn/signInPage.dart';
import 'package:home_trainer/app/services/loadingScreen.dart';

class AuthenticationWrapper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthenticationWrapperState();
}

class AuthenticationWrapperState extends State<AuthenticationWrapper> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Timer _timer;
  User _user;

  @override
  void initState() {
    _user = _firebaseAuth.currentUser;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    if (_user != null) {
      _user = _firebaseAuth.currentUser;
      await _user.reload();
      if (_user.emailVerified) {
        _timer.cancel();
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    final currentUser = FirebaseAuth.instance.currentUser;
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    if (firebaseUser != null) {
      if (firebaseUser.emailVerified) {
        return StreamBuilder<DocumentSnapshot>(
          stream: users.doc(currentUser.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }

            Map<String, dynamic> data = snapshot.data.data();
            if (!data['hasData']) {
              return CreateUserInfoData(uid: currentUser.uid);
            }
            return NavigationController();
          },
        );
      }
    }
    return SignInPage();
  }
}
