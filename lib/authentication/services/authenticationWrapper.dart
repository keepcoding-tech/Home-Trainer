import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/authentication/screens/signIn/signInPage.dart';
import 'package:home_trainer/app/screens/profile/profilePage.dart';

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

    if (firebaseUser != null) {
      if (firebaseUser.emailVerified) {
        return ProfilePage();
      }
    }
    return SignInPage();
  }
}
