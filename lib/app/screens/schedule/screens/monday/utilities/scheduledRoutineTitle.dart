import 'package:flutter/material.dart';

import 'package:home_trainer/app/utilities/constantsStyles.dart';

class ScheduledRoutineTitle extends StatelessWidget {
  ScheduledRoutineTitle({@required this.routineTitle});
  final String routineTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: Divider(
                indent: 15.0,
                endIndent: 15.0,
                thickness: 2,
                color: kIconColor,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                routineTitle,
                style: kSubtitleLabelTextStyle,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Divider(
                indent: 15.0,
                endIndent: 15.0,
                thickness: 2,
                color: kIconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
