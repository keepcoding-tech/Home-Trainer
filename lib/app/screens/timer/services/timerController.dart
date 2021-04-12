import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/utilities/roundIconButtone.dart';
import 'package:home_trainer/app/screens/timer/utilities/timerButtone.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

enum TimeInput { minutes, seconds }

class TimerController extends StatefulWidget {
  @override
  _TimerControllerState createState() => _TimerControllerState();
}

class _TimerControllerState extends State<TimerController> {
  Timer timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsLabelText > 0) {
          secondsLabelText--;
        } else if (secondsLabelText == 0 && minutesLabelText > 0) {
          secondsLabelText = 59;
          minutesLabelText--;
        } else if (minutesLabelText == 0 && secondsLabelText == 0) {
          timer.cancel();
          timeStarted = false;
        }
      });
    });
  }

  Function increase(TimeInput input) {
    return () {
      setState(() {
        if (input == TimeInput.minutes) {
          if (minutesLabelText < 59) {
            minutesLabelText++;
          } else {
            minutesLabelText = 0;
          }
        } else if (input == TimeInput.seconds) {
          if (secondsLabelText < 59) {
            secondsLabelText++;
          } else {
            secondsLabelText = 0;
          }
        }
      });
    };
  }

  Function decrease(TimeInput input) {
    return () {
      setState(() {
        if (input == TimeInput.minutes) {
          if (minutesLabelText > 0) {
            minutesLabelText--;
          } else {
            minutesLabelText = 59;
          }
        } else if (input == TimeInput.seconds) {
          if (secondsLabelText > 0) {
            secondsLabelText--;
          } else {
            secondsLabelText = 59;
          }
        }
      });
    };
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
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        !timeStarted
                            ? RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: increase(TimeInput.minutes),
                              )
                            : Text(''),
                        SizedBox(height: 20.0),
                        Text(
                          minutesLabelText < 10
                              ? '0${minutesLabelText.toString()}'
                              : minutesLabelText.toString(),
                          style: kTimerLabelTextStyle,
                        ),
                        SizedBox(height: 20.0),
                        !timeStarted
                            ? RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: decrease(TimeInput.minutes),
                              )
                            : Text(''),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ':',
                        style: TextStyle(
                          fontSize: 80.0,
                          color: Color(0xFFCBD7F6),
                        ),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        !timeStarted
                            ? RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: increase(TimeInput.seconds),
                              )
                            : Text(''),
                        SizedBox(height: 20.0),
                        Text(
                          secondsLabelText < 10
                              ? '0${secondsLabelText.toString()}'
                              : secondsLabelText.toString(),
                          style: kTimerLabelTextStyle,
                        ),
                        SizedBox(height: 20.0),
                        !timeStarted
                            ? RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: decrease(TimeInput.seconds),
                              )
                            : Text(''),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: !timeStarted
                ? TimerButton(
                    labelName: 'START',
                    color: kButtonColor,
                    onPressed: minutesLabelText == 0 && secondsLabelText == 0
                        ? null
                        : () {
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
                            ? TimerButton(
                                labelName: 'PAUSE',
                                color: kButtonColor,
                                onPressed: () {
                                  setState(() {
                                    timer.cancel();
                                    timerPaused = true;
                                  });
                                },
                              )
                            : TimerButton(
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
                        child: TimerButton(
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
