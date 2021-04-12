import 'package:flutter/material.dart';

import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:home_trainer/database/utilities/routine.dart';

class RoutineSelectableTile extends StatefulWidget {
  final Routine routine;
  RoutineSelectableTile({this.routine});

  @override
  _RoutineSelectableTileState createState() =>
      _RoutineSelectableTileState(routine: routine);
}

class _RoutineSelectableTileState extends State<RoutineSelectableTile> {
  final Routine routine;
  _RoutineSelectableTileState({this.routine});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kActiveCardColor,
      child: ListTile(
        title: Text(
          routine.title,
          style: kTitleLabelTextStyle,
        ),
        subtitle: Text(
          routine.sport,
          style: kSubtitleLabelTextStyle,
        ),
        trailing: Transform.scale(
          scale: 2.0,
          child: Checkbox(
            activeColor: kButtonColor,
            value: routine.isSelected ?? false,
            onChanged: (value) {
              setState(() {
                routine.isSelected = !routine.isSelected;
              });
            },
          ),
        ),
      ),
    );
  }
}
