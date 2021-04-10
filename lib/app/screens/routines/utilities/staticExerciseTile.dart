import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:home_trainer/app/screens/routines/editStaticExercisePage.dart';
import 'package:home_trainer/app/screens/routines/utilities/detailExerciseCard.dart';
import 'package:home_trainer/app/screens/routines/utilities/showAlertDialogMessage.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class StaticExerciseTile extends StatelessWidget {
  final bool isModifiable;
  final String routine,
      exercise,
      muscle,
      sets,
      reps,
      weight,
      restTimeMin,
      restTimeSec;
  StaticExerciseTile({
    this.isModifiable,
    this.routine,
    this.exercise,
    this.muscle,
    this.sets,
    this.reps,
    this.weight,
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
                    'MUSCLE:  $muscle',
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
                              builder: (context) => EditStaticExercisePage(
                                routineTitle: routine,
                                exerciseTitle: exercise,
                                muscle: muscle,
                                sets: sets,
                                reps: reps,
                                weight: weight,
                                restTimeMin: restTimeMin,
                                restTimeSec: restTimeSec,
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
                            messageTitle: 'Delete Exercise',
                            messageDetails:
                                'Are you sure you want to delate the exercise?',
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
          DetailExerciseCard(
            cardChild: Text(
              'EXERCISE:  $exercise',
              style: kSubtitleLabelTextStyle,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: DetailExerciseCard(
                  cardChild: Text(
                    'SETS:  $sets',
                    style: kSubtitleLabelTextStyle,
                  ),
                ),
              ),
              Expanded(
                child: DetailExerciseCard(
                  cardChild: Text(
                    'REPS:  $reps',
                    style: kSubtitleLabelTextStyle,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: DetailExerciseCard(
                  cardChild: Text(
                    'WEIGHT:  $weight Kg',
                    style: kSubtitleLabelTextStyle,
                  ),
                ),
              ),
              Expanded(
                child: DetailExerciseCard(
                  cardChild: Text(
                    'REST TIME:  $restTimeMin:$restTimeSec',
                    style: kSubtitleLabelTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
