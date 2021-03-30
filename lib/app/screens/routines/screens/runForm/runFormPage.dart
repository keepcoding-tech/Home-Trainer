import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/screens/runForm/services/runController.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineAppBar.dart';

class RunFormPage extends StatefulWidget {
  @override
  _RunFormPageState createState() => _RunFormPageState();
}

class _RunFormPageState extends State<RunFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: RoutineAppBar(title: 'RUN'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: RunFormController(),
        ),
      ),
    );
  }
}
