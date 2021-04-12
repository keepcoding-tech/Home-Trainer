import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:provider/provider.dart';

import 'package:home_trainer/app/screens/schedule/services/addRoutineToScheduleController.dart';
import 'package:home_trainer/database/routineDatabaseController.dart';
import 'package:home_trainer/database/utilities/routine.dart';

class AddRoutineToSchedulePage extends StatefulWidget {
  final String weekDay;
  AddRoutineToSchedulePage({this.weekDay});

  @override
  _AddRoutineToSchedulePageState createState() =>
      _AddRoutineToSchedulePageState();
}

class _AddRoutineToSchedulePageState extends State<AddRoutineToSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Routine>>.value(
      value: RoutineDatabaseController().routine,
      // ignore: deprecated_member_use
      initialData: List(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ADD ROUTINE TO SCHEDULE',
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
        body: SafeArea(
          child: AddRoutineToScheduleController(
            weekday: widget.weekDay,
          ),
        ),
      ),
    );
  }
}
