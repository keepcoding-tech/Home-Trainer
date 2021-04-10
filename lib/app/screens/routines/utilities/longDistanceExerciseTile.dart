import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/editLongDistanceExercisePage.dart';
import 'package:home_trainer/app/screens/routines/utilities/detailExerciseCard.dart';
import 'package:home_trainer/app/screens/routines/utilities/showAlertDialogMessage.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class LongDistanceExerciseTile extends StatelessWidget {
  final bool isModifiable;
  final String routine,
      exercise,
      distance,
      intervals,
      intensity,
      restTimeMin,
      restTimeSec,
      intensityTextLabel;
  LongDistanceExerciseTile({
    this.isModifiable,
    this.routine,
    this.exercise,
    this.distance,
    this.intervals,
    this.restTimeMin,
    this.restTimeSec,
    this.intensity,
    this.intensityTextLabel,
  });

  final _currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference _routineColection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: kInactiveCardColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: DetailExerciseCard(
                  cardChild: Text(
                    'DISTANCE:  $distance Km',
                    style: kSubtitleLabelTextStyle,
                  ),
                ),
              ),
              isModifiable
                  ? DetailExerciseCard(
                      cardChild: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.pencilAlt,
                          color: kIconColor,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditLongDistanceExercisePage(
                                routineTitle: routine,
                                exerciseTitle: exercise,
                                distance: distance,
                                intervals: intervals,
                                intensity: intensity,
                                restTimeMin: restTimeMin,
                                restTimeSec: restTimeSec,
                                intensityTextLabe: intensityTextLabel,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Text(''),
              isModifiable
                  ? DetailExerciseCard(
                      cardChild: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.trash,
                          color: kIconColor,
                        ),
                        onPressed: () {
                          showAlertDialogMessage(
                            context: context,
                            messageTitle: 'Delete exercise',
                            messageDetails:
                                'Are you sure you want to delete the exercise?',
                            onPressed: () {
                              _routineColection
                                  .doc(_currentUser.uid)
                                  .collection('routines')
                                  .doc(routine)
                                  .collection('exercises')
                                  .doc(exercise)
                                  .delete();
                            },
                          );
                        },
                      ),
                    )
                  : Text(''),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: DetailExerciseCard(
                  cardChild: Text(
                    'INTERVALS: $intervals',
                    style: kSubtitleLabelTextStyle,
                  ),
                ),
              ),
              Expanded(
                child: DetailExerciseCard(
                  cardChild: Text(
                    int.parse(restTimeSec) < 10
                        ? 'REST TIME: $restTimeMin : 0$restTimeSec'
                        : 'REST TIME: $restTimeMin : $restTimeSec',
                    style: kSubtitleLabelTextStyle,
                  ),
                ),
              ),
            ],
          ),
          DetailExerciseCard(
            cardChild: Text('$intensity', style: kSubtitleLabelTextStyle),
          ),
        ],
      ),
    );
  }
}
