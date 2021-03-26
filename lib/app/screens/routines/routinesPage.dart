import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:home_trainer/app/screens/routines/utilities/routinesList.dart';
import 'package:home_trainer/database/routineDatabaseController.dart';
import 'package:home_trainer/database/utilities/routine.dart';

class RoutinesPage extends StatefulWidget {
  @override
  _RoutinesPageState createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Routine>>.value(
      value: RoutineDatabaseController().routine,
      // ignore: deprecated_member_use
      initialData: List(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Routines page'),
        ),
        body: SafeArea(child: RoutinesList()),
      ),
    );
  }
}
