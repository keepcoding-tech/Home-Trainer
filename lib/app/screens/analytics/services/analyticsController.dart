import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

import 'package:home_trainer/app/utilities/selectableCard.dart';
import 'package:home_trainer/app/utilities/unitInputCard.dart';
import 'package:home_trainer/database/usersDatabaseController.dart';

enum Gender { male, female }

class AnalyticsController extends StatefulWidget {
  @override
  _AnalyticsControllerState createState() => _AnalyticsControllerState();
}

class _AnalyticsControllerState extends State<AnalyticsController> {
  int weight = 65, age = 18, height = 170;

  String gender = 'MALE';
  Gender selectedGender = Gender.male;
  final Color activeColor = Colors.blueGrey[700];
  final Color inactiveColor = Colors.blueGrey[600];

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            'MALE',
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
                      Text(height.toString(), style: kSubtitleLabelTextStyle),
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
                    inputText:
                        Text(weight.toString(), style: kSubtitleLabelTextStyle),
                    cardColor: kActiveCardColor,
                    sizedBoxHeight: 0.0,
                    onPressedMinus: () {
                      setState(() {
                        weight--;
                      });
                    },
                    onPressedPlus: () {
                      setState(() {
                        weight++;
                      });
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
                    sizedBoxHeight: 0.0,
                    onPressedMinus: () {
                      setState(() {
                        age--;
                      });
                    },
                    onPressedPlus: () {
                      setState(() {
                        age++;
                      });
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
              await UserDatabaseController(uid: currentUser.uid).updateUserData(
                gender,
                height.toString(),
                weight.toString(),
                age.toString(),
              );
            },
          ),
        ],
      ),
    );
  }
}
