import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/schedule/screens/monday/%20mondayScheduleDayPage.dart';
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
                    builder: (context) => MondayScheduleDayPage(
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
              onPressed: () {},
            ),
          ),
          Expanded(
            child: DayCard(
              labelText: 'Wednesday',
              onPressed: () {},
            ),
          ),
          Expanded(
            child: DayCard(
              labelText: 'Thursday',
              onPressed: () {},
            ),
          ),
          Expanded(
            child: DayCard(
              labelText: 'Friday',
              onPressed: () {},
            ),
          ),
          Expanded(
            child: DayCard(
              labelText: 'Saturday',
              onPressed: () {},
            ),
          ),
          Expanded(
            child: DayCard(
              labelText: 'Sunday',
              onPressed: () {},
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
