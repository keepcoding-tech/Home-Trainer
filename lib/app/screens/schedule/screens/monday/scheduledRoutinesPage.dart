import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_trainer/app/screens/schedule/addRoutineToSchedulePage.dart';

import 'package:home_trainer/app/screens/schedule/screens/monday/services/scheduledRoutinesController.dart';
import 'package:home_trainer/app/utilities/actionButton.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class ScheduledRoutinesPage extends StatefulWidget {
  final String weekday;
  ScheduledRoutinesPage({this.weekday});

  @override
  _ScheduledRoutinesPageState createState() => _ScheduledRoutinesPageState();
}

class _ScheduledRoutinesPageState extends State<ScheduledRoutinesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.weekday.toUpperCase(),
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
      floatingActionButton: ActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddRoutineToSchedulePage(weekDay: widget.weekday),
            ),
          );
        },
      ),
      body: SafeArea(
        child: ScheduledRoutinesController(
          weekday: widget.weekday,
        ),
      ),
    );
  }
}
