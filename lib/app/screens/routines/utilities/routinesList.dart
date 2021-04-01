import 'package:firebase_auth/firebase_auth.dart';
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
          }),
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
      color: Colors.blueGrey[400],
      child: ListTile(
        title: Text(routine.title),
        subtitle: Text(routine.sport),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward),
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
