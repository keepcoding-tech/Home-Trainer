import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/screens/cyclingForm/cyclingFormPage.dart';
import 'package:home_trainer/app/screens/routines/screens/gymForm/gymFormPage.dart';
import 'package:home_trainer/app/screens/routines/screens/runForm/runFormPage.dart';
import 'package:home_trainer/app/screens/routines/screens/swimForm/swimFormPage.dart';

Future<void> showChoseSportMessage(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chose a sport type'),
          actions: [
            TextButton(
              child: Text('BACK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          content: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        child: Text('GYM'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GymFormPage()));
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text('RUN'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RunFormPage()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        child: Text('SWIM'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SwimFormPage()));
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text('CYCLING'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CyclingFormPage()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        child: Text('YOGA'),
                        onPressed: () {
                          print('no page provided for this sport');
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text('WALK'),
                        onPressed: () {
                          print('no page provided for this sport');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
