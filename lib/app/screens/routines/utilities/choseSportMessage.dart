import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/screens/cyclingForm/cyclingFormPage.dart';
import 'package:home_trainer/app/screens/routines/screens/gymForm/gymFormPage.dart';
import 'package:home_trainer/app/screens/routines/screens/runForm/runFormPage.dart';
import 'package:home_trainer/app/screens/routines/screens/swimForm/swimFormPage.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

Future<void> choseSportMessage(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: kInactiveCardColor,
        title: Text(
          'Chose a sport type',
          style: kSubtitleLabelTextStyle,
        ),
        actions: [
          TextButton(
            child: Text('BACK', style: kButtonLabelTextStyle),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        content: Column(
          children: <Widget>[
            Expanded(
              child: SportCard(
                labelText: 'GYM',
                icon: FontAwesomeIcons.dumbbell,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GymFormPage(),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: SportCard(
                labelText: 'RUN',
                icon: FontAwesomeIcons.running,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RunFormPage(),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: SportCard(
                labelText: 'CYCLING',
                icon: FontAwesomeIcons.bicycle,
                // Icons.pedal_bike,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CyclingFormPage(),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: SportCard(
                labelText: 'SWIM',
                icon: FontAwesomeIcons.swimmer,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SwimFormPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

class SportCard extends StatelessWidget {
  SportCard({this.labelText, this.icon, this.onTap});
  final Function onTap;
  final IconData icon;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: kActiveCardColor,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(icon, color: kInactiveCardColor, size: 100),
            ),
            Center(
              child: Text(labelText, style: kTitleLabelTextStyle),
            )
          ],
        ),
      ),
    );
  }
}
