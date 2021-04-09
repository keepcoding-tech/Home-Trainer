import 'dart:async';

import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/routineButton.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class StopwatchController extends StatefulWidget {
  @override
  _StopwatchControllerState createState() => _StopwatchControllerState();
}

class _StopwatchControllerState extends State<StopwatchController> {
  Timer timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsLabelText < 59) {
          secondsLabelText++;
        } else if (secondsLabelText == 59) {
          secondsLabelText = 0;
          minutesLabelText++;
        } else if (minutesLabelText == 59 && secondsLabelText == 59) {
          timer.cancel();
          timeStarted = false;
        }
      });
    });
  }

  int minutesLabelText = 0, secondsLabelText = 0;
  bool timeStarted = false, timerPaused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: kActiveCardColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Expanded(
                      child: Text(
                        minutesLabelText < 10
                            ? '0${minutesLabelText.toString()}'
                            : minutesLabelText.toString(),
                        style: kTimerLabelTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Center(
                    child: Expanded(
                      child: Text(
                        ':',
                        style: TextStyle(
                          fontSize: 80.0,
                          color: Color(0xFFCBD7F6),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Center(
                    child: Expanded(
                      child: Text(
                        secondsLabelText < 10
                            ? '0${secondsLabelText.toString()}'
                            : secondsLabelText.toString(),
                        style: kTimerLabelTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: !timeStarted
                ? RoutineButton(
                    labelName: 'START',
                    color: kButtonColor,
                    onPressed: () {
                      setState(() {
                        timeStarted = true;
                        startTimer();
                      });
                    },
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: !timerPaused
                            ? RoutineButton(
                                labelName: 'PAUSE',
                                color: kButtonColor,
                                onPressed: () {
                                  setState(() {
                                    timer.cancel();
                                    timerPaused = true;
                                  });
                                },
                              )
                            : RoutineButton(
                                labelName: 'RESUME',
                                color: kButtonColor,
                                onPressed: () {
                                  setState(() {
                                    timerPaused = false;
                                    startTimer();
                                  });
                                },
                              ),
                      ),
                      Expanded(
                        child: RoutineButton(
                          labelName: 'STOP',
                          color: kButtonColor,
                          onPressed: () {
                            setState(() {
                              timeStarted = false;
                              minutesLabelText = 0;
                              secondsLabelText = 0;
                              timer.cancel();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
