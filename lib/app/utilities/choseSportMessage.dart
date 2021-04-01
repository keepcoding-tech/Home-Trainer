import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/screens/cyclingForm/cyclingFormPage.dart';
import 'package:home_trainer/app/screens/routines/screens/gymForm/gymFormPage.dart';
import 'package:home_trainer/app/screens/routines/screens/runForm/runFormPage.dart';
import 'package:home_trainer/app/screens/routines/screens/swimForm/swimFormPage.dart';

Future<void> choseSportMessage(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Chose a sport type',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'BACK',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
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
                  icon: Icons.fitness_center,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GymFormPage()));
                  },
                ),
              ),
              Expanded(
                child: SportCard(
                  labelText: 'RUN',
                  icon: Icons.directions_run,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RunFormPage()));
                  },
                ),
              ),
              Expanded(
                child: SportCard(
                  labelText: 'CYCLING',
                  icon: Icons.pedal_bike,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CyclingFormPage()));
                  },
                ),
              ),
              Expanded(
                child: SportCard(
                  labelText: 'SWIM',
                  icon: Icons.pool,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SwimFormPage()));
                  },
                ),
              ),
            ],
          ),
        );
      });
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
        color: Colors.blueGrey[300],
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(icon, size: 100),
            ),
            Center(
              child: Text(
                labelText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
