import 'package:flutter/material.dart';
import 'package:home_trainer/app/screens/schedule/addRoutineToSchedulePage.dart';

import 'package:home_trainer/app/screens/schedule/screens/monday/services/mondayScheduleController.dart';
import 'package:home_trainer/app/utilities/actionButton.dart';

class MondayScheduleDayPage extends StatefulWidget {
  final String weekday;
  MondayScheduleDayPage({this.weekday});

  @override
  _MondayScheduleDayPageState createState() => _MondayScheduleDayPageState();
}

class _MondayScheduleDayPageState extends State<MondayScheduleDayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.weekday),
      ),
      floatingActionButton: ActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddRoutineToSchedulePage(weekDay: widget.weekday),
            ),
          );
        },
      ),
      body: SafeArea(
        child: MondayScheduleController(
          weekday: widget.weekday,
        ),
      ),
    );
  }
}
