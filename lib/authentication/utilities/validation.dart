import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Validation {
  String Function(String) nameValidator() {
    return (String value) {
      if (value.isEmpty) {
        return 'A name is required';
      }
      return null;
    };
  }

  String Function(String) emailValidator() {
    return (String value) {
      if (value.isEmpty) {
        return 'An email is required';
      }
      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+" +
              "-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return 'Enter a valid email';
      }

      return null;
    };
  }

  String Function(String) createAccountEmailValidator(BuildContext context) {
    final _users = Provider.of<QuerySnapshot>(context);
    return (String value) {
      if (value.isEmpty) {
        return 'An email is required';
      }
      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+" +
              "-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return 'Enter a valid email';
      }
      for (var doc in _users.docs) {
        if (value == doc.data()['email']) {
          return "The email is alrady in use";
        }
      }
      return null;
    };
  }

  String Function(String) passwordValidator() {
    return (String value) {
      if (value.isEmpty) {
        return 'A password is required';
      }
      if (value.length < 6) {
        return 'Password must be at least 6 characters';
      }
      return null;
    };
  }

  // String Function(String) confirmPasswordValidator(String password) {
  //   print(password);
  //   return (String value) {
  //     if (value.isEmpty) {
  //       return 'A password is required';
  //     }
  //     if (value != password) {
  //       return 'The passwords doesn\'t mach';
  //     }
  //     return null;
  //   };
  // }
}
