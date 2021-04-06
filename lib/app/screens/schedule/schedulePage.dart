import 'package:flutter/material.dart';
import 'package:home_trainer/app/screens/schedule/services/scheduleController.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'SCHEDULE',
            style: kTitleLabelTextStyle,
          ),
        ),
      ),
      body: ScheduleController(),
    );
  }
}
