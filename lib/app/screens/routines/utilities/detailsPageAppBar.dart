import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:home_trainer/app/screens/routines/utilities/showAlertDialogMessage.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class DetailsPageAppBar extends StatelessWidget {
  const DetailsPageAppBar({this.routineTitle});
  final String routineTitle;

  @override
  Widget build(BuildContext context) {
    final _currentUser = FirebaseAuth.instance.currentUser;
    final CollectionReference _routineColection =
        FirebaseFirestore.instance.collection('users');

    return AppBar(
      title: Text(
        routineTitle,
        style: kTitleLabelTextStyle,
      ),
      leading: IconButton(
        icon: Icon(
          FontAwesomeIcons.arrowLeft,
          color: kIconColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(FontAwesomeIcons.trash),
          onPressed: () {
            showAlertDialogMessage(
              context: context,
              messageTitle: 'Delete Routine',
              messageDetails:
                  'Are you sure you want to delete the whole routine?',
              onPressed: () {
                _routineColection
                    .doc(_currentUser.uid)
                    .collection('routines')
                    .doc(routineTitle)
                    .collection('exercises')
                    .get()
                    .then((snapshot) {
                  for (DocumentSnapshot ds in snapshot.docs) {
                    ds.reference.delete();
                  }
                });

                _routineColection
                    .doc(_currentUser.uid)
                    .collection('routines')
                    .doc(routineTitle)
                    .delete();

                Navigator.pop(context);
              },
            );
          },
        ),
      ],
    );
  }
}
