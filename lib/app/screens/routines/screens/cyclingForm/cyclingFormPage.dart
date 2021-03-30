import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/screens/cyclingForm/services/cyclingController.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineAppBar.dart';

class CyclingFormPage extends StatefulWidget {
  @override
  _CyclingFormPageState createState() => _CyclingFormPageState();
}

class _CyclingFormPageState extends State<CyclingFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: RoutineAppBar(title: 'CYCLING'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: CyclingFormController(),
        ),
      ),
    );
  }
}
