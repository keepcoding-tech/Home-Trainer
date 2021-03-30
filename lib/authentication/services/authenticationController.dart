import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_trainer/database/usersDatabaseController.dart';

class AuthenticationController {
  final FirebaseAuth _firebaseAuth;
  AuthenticationController(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  // Authentification with email and password
  Future<UserCredential> signIn(
      {String email, String password, BuildContext context}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // show no user found message
      if (e.code == 'user-not-found') {
        print('No user found for that email.');

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found with this email')));
        // show wrong password message
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong password provided for that user')));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserCredential> signUp({
    String name,
    String email,
    String password,
    BuildContext context,
  }) async {
    UserCredential userCredential;
    try {
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await UserDatabaseController(uid: userCredential.user.uid)
          .createUserData(name, email);

      _firebaseAuth.currentUser.sendEmailVerification();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // show weak password message
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The password provided is too weak')));
        // show email already in use message
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('The account already exists for that email')));
      }
      return userCredential;
    } catch (e) {
      return userCredential;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Authentification with Facebook
  Future<UserCredential> signInWithFacebook(BuildContext context) async {
    try {
      final FacebookLogin _facebookLogin = new FacebookLogin();
      final FacebookLoginResult result = await _facebookLogin.logIn(['email']);

      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken.token);

      final UserCredential _userCrediential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      await UserDatabaseController(uid: _userCrediential.user.uid)
          .createUserData('ceva', 'ceva');

      return await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      // show account already exists message
      if (e.code == 'account-exists-with-different-credential') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('The account already exists with these credentials'),
        ));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Authentification with Google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential _userCrediential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    await UserDatabaseController(uid: _userCrediential.user.uid)
        .createUserData(googleUser.email, googleUser.email);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Reset password
  Future<void> resetPassword({String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
