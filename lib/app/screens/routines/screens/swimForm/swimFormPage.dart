import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/screens/swimForm/services/swimController.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineAppBar.dart';

class SwimFormPage extends StatefulWidget {
  @override
  _SwimFormPageState createState() => _SwimFormPageState();
}

class _SwimFormPageState extends State<SwimFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: RoutineAppBar(title: 'SWIM'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SwimFormController(),
        ),
      ),
    );
  }
}
