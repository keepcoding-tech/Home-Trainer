import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:home_trainer/app/screens/routines/editShortDistanceExercisePage.dart';
import 'package:home_trainer/app/screens/routines/utilities/detailExerciseCard.dart';
import 'package:home_trainer/app/screens/routines/utilities/showAlertDialogMessage.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class ShortDistanceExerciseTile extends StatelessWidget {
  final String routine,
      exerciseTitle,
      distance,
      style,
      sessions,
      restTimeMin,
      restTimeSec;
  ShortDistanceExerciseTile({
    this.routine,
    this.exerciseTitle,
    this.distance,
    this.style,
    this.sessions,
    this.restTimeMin,
    this.restTimeSec,
  });

  final _currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference _routineColection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      color: kInactiveCardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: DetailExerciseCard(
                  cardChild: Center(
                    child: Text(
                      'DISTANCE:  $distance m',
                      style: kSubtitleLabelTextStyle,
                    ),
                  ),
                ),
              ),
              DetailExerciseCard(
                cardChild: Center(
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.pencilAlt,
                      color: kIconColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditShortDistanceExercisePage(
                            routineTitle: routine,
                            exerciseTitle: exerciseTitle,
                            distance: distance,
                            style: style,
                            sessions: sessions,
                            restTimeMin: restTimeMin,
                            restTimeSec: restTimeSec,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              DetailExerciseCard(
                cardChild: Center(
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.trash,
                      color: kIconColor,
                    ),
                    onPressed: () {
                      showAlertDialogMessage(
                        context: context,
                        messageTitle: 'Delete Routine',
                        messageDetails: 'Are you sure?',
                        onPressed: () {
                          _routineColection
                              .doc(_currentUser.uid)
                              .collection('routines')
                              .doc(routine)
                              .collection('exercises')
                              .doc(exerciseTitle)
                              .delete();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: DetailExerciseCard(
                  cardChild: Center(
                    child: Text(
                      'SESSIONS: $sessions',
                      style: kSubtitleLabelTextStyle,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: DetailExerciseCard(
                  cardChild: Center(
                    child: Text(
                      'REST TIME: $restTimeMin : $restTimeSec',
                      style: kSubtitleLabelTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          DetailExerciseCard(
            cardChild: Center(
              child: Text(
                style.toUpperCase(),
                style: kSubtitleLabelTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
