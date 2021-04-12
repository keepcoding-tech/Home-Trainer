import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/detailPage.dart';
import 'package:home_trainer/database/utilities/routine.dart';

class RoutinesList extends StatefulWidget {
  @override
  _RoutinesListState createState() => _RoutinesListState();
}

class _RoutinesListState extends State<RoutinesList> {
  @override
  Widget build(BuildContext context) {
    final routine = Provider.of<List<Routine>>(context) ?? [];

    return Container(
      child: ListView.builder(
        itemCount: routine.length,
        itemBuilder: (context, index) {
          return RoutineTile(routine: routine[index]);
        },
      ),
    );
  }
}

class RoutineTile extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;
  final Routine routine;
  RoutineTile({this.routine});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kActiveCardColor,
      child: ListTile(
        title: Text(routine.title, style: kTitleLabelTextStyle),
        subtitle: Text(routine.sport, style: kSubtitleLabelTextStyle),
        trailing: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowRight,
            color: kIconColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  title: routine.title,
                  sport: routine.sport,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
