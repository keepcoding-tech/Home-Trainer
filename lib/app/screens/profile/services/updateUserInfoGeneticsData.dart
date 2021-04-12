import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_trainer/app/services/loadingScreen.dart';

import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:home_trainer/app/utilities/selectableCard.dart';
import 'package:home_trainer/app/utilities/unitInputCard.dart';
import 'package:home_trainer/database/usersDatabaseController.dart';

class UserInfoGeneticsData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(currentUser.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return UpdateUserInfoGeneticsData(
            weight: int.parse(data['weight']),
            age: int.parse(data['age']),
            height: int.parse(data['height']),
            gender: data['gender'],
            context: context,
          );
        }

        return LoadingAnimation(loadingSize: 50.0);
      },
    );
  }
}

enum Gender { male, female }

class UpdateUserInfoGeneticsData extends StatefulWidget {
  final int weight, age, height;
  final String gender;
  final BuildContext context;
  UpdateUserInfoGeneticsData(
      {this.weight, this.age, this.height, this.gender, this.context});

  @override
  _UpdateUserInfoGeneticsDataState createState() =>
      _UpdateUserInfoGeneticsDataState(
        weight: weight,
        age: age,
        height: height,
        gender: gender,
      );
}

class _UpdateUserInfoGeneticsDataState
    extends State<UpdateUserInfoGeneticsData> {
  _UpdateUserInfoGeneticsDataState({
    this.weight,
    this.age,
    this.height,
    this.gender,
  });

  int weight, age, height;
  String gender;

  Gender selectedGender = Gender.male;

  final currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  double calculateBMI() {
    double _bmi = weight / pow(height / 100, 2);
    double mod = pow(10.0, 2);
    return ((_bmi * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UPDATE INFO',
          style: kTitleLabelTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            color: kIconColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SelectableCard(
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Icon(
                                FontAwesomeIcons.mars,
                                color: kIconColor,
                                size: 80.0,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'MALE',
                                style: kTitleLabelTextStyle,
                              ),
                            ),
                          ],
                        ),
                        color: selectedGender == Gender.male
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        onPressed: () {
                          setState(() {
                            gender = 'MALE';
                            selectedGender = Gender.male;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: SelectableCard(
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Icon(
                                FontAwesomeIcons.venus,
                                color: kIconColor,
                                size: 80.0,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'FEMALE',
                                style: kTitleLabelTextStyle,
                              ),
                            ),
                          ],
                        ),
                        color: selectedGender == Gender.female
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        onPressed: () {
                          setState(() {
                            gender = 'FEMALE';
                            selectedGender = Gender.female;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: kActiveCardColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('HEIGHT', style: kTitleLabelTextStyle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(height.toString(),
                              style: kSubtitleLabelTextStyle),
                          Text('cm', style: kSubtitleLabelTextStyle),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Color(0xFF999EC1),
                          thumbColor: kButtonColor,
                          overlayColor: Color(0x307F6AFA),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0),
                        ),
                        child: Slider(
                          value: height.toDouble(),
                          min: 100.0,
                          max: 220.0,
                          inactiveColor: Color(0xFF8D8E98),
                          onChanged: (value) {
                            setState(() {
                              height = value.round();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: UnitInputCard(
                        labelText: 'WEIGHT',
                        inputText: Text(
                          '${weight.toString()} kg',
                          style: kSubtitleLabelTextStyle,
                        ),
                        cardColor: kActiveCardColor,
                        sizedBoxHeight: 5.0,
                        onPressedMinus: () {
                          if (weight > 30) {
                            setState(() {
                              weight--;
                            });
                          }
                        },
                        onPressedPlus: () {
                          if (weight < 199) {
                            setState(() {
                              weight++;
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: UnitInputCard(
                        labelText: 'AGE',
                        inputText: Text(
                          age.toString(),
                          style: kSubtitleLabelTextStyle,
                        ),
                        cardColor: kActiveCardColor,
                        sizedBoxHeight: 5.0,
                        onPressedMinus: () {
                          if (age > 8) {
                            setState(() {
                              age--;
                            });
                          }
                        },
                        onPressedPlus: () {
                          if (age < 80) {
                            setState(() {
                              age++;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Container(
                  child: Center(
                    child: Text('SAVE', style: kButtonLabelTextStyle),
                  ),
                  color: kButtonColor,
                  margin: EdgeInsets.only(top: 10.0),
                  width: double.infinity,
                  height: 80.0,
                ),
                onTap: () async {
                  await UserDatabaseController(uid: currentUser.uid)
                      .updateUserInfoData(
                    gender,
                    height.toString(),
                    weight.toString(),
                    age.toString(),
                  );

                  await UserDatabaseController(uid: currentUser.uid)
                      .updateUserInfoGeneticsData(calculateBMI());

                  Navigator.pop(widget.context);
                  Navigator.pop(widget.context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
