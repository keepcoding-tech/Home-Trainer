import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/schedule/screens/monday/scheduledRoutinesPage.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class ScheduleController extends StatefulWidget {
  @override
  _ScheduleControllerState createState() => _ScheduleControllerState();
}

class _ScheduleControllerState extends State<ScheduleController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: DayCard(
              labelText: 'Monday',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduledRoutinesPage(
                      weekday: 'Monday',
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: DayCard(
              labelText: 'Tuesday',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduledRoutinesPage(
                      weekday: 'Tuesday',
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: DayCard(
              labelText: 'Wednesday',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduledRoutinesPage(
                      weekday: 'Wednesday',
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: DayCard(
              labelText: 'Thursday',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduledRoutinesPage(
                      weekday: 'Thursday',
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: DayCard(
              labelText: 'Friday',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduledRoutinesPage(
                      weekday: 'Friday',
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: DayCard(
              labelText: 'Saturday',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduledRoutinesPage(
                      weekday: 'Saturday',
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: DayCard(
              labelText: 'Sunday',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduledRoutinesPage(
                      weekday: 'Sunday',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DayCard extends StatelessWidget {
  const DayCard({this.labelText, this.onPressed});
  final Function onPressed;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Center(
          child: Text(
            labelText,
            style: kTitleLabelTextStyle,
          ),
        ),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: kActiveCardColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
