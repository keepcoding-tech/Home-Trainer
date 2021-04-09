import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/authentication/screens/signUp/utilities/emailVerificationMessage.dart';
import 'package:home_trainer/authentication/services/authenticationController.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:home_trainer/app/utilities/selectableCard.dart';
import 'package:home_trainer/app/utilities/unitInputCard.dart';

enum Gender { male, female }

class CreateUserInfoGeneticsData extends StatefulWidget {
  final String fullName, email, password, authMethod;
  CreateUserInfoGeneticsData(
      {this.fullName, this.email, this.password, this.authMethod});

  @override
  _CreateUserInfoGeneticsDataState createState() =>
      _CreateUserInfoGeneticsDataState();
}

class _CreateUserInfoGeneticsDataState
    extends State<CreateUserInfoGeneticsData> {
  int weight = 65, age = 18, height = 170;

  String gender = 'MALE';
  Gender selectedGender = Gender.male;
  final Color activeColor = Colors.blueGrey[700];
  final Color inactiveColor = Colors.blueGrey[600];

  final currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  double calculateBMI() {
    double _bmi = weight / pow(height / 100, 2);
    return _bmi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CREATE USER INFO',
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
                        sizedBoxHeight: 15.0,
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
                        sizedBoxHeight: 15.0,
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
                    child: Text('CREATE ACCOUNT', style: kButtonLabelTextStyle),
                  ),
                  color: kButtonColor,
                  margin: EdgeInsets.only(top: 10.0),
                  width: double.infinity,
                  height: 80.0,
                ),
                onTap: () async {
                  if (widget.authMethod == 'email & password') {
                    context
                        .read<AuthenticationController>()
                        .signUp(
                          email: widget.email,
                          password: widget.password,
                          name: widget.fullName,
                          gender: gender,
                          height: height.toString(),
                          weight: weight.toString(),
                          age: age.toString(),
                          analyticData: <double>[calculateBMI()],
                          context: context,
                        )
                        .then((_) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();

                      showEmailVerificationMessage(context, widget.email);
                    });
                  } else if (widget.authMethod == 'facebook') {
                    context
                        .read<AuthenticationController>()
                        .signInWithFacebook(
                          context,
                          name: widget.fullName,
                          gender: gender,
                          height: height.toString(),
                          weight: weight.toString(),
                          age: age.toString(),
                        )
                        .then((_) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                  } else if (widget.authMethod == 'google') {
                    context
                        .read<AuthenticationController>()
                        .signInWithGoogle(
                          name: widget.fullName,
                          gender: gender,
                          height: height.toString(),
                          weight: weight.toString(),
                          age: age.toString(),
                        )
                        .then((_) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
