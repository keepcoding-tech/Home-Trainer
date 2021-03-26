import 'package:flutter/material.dart';
import 'package:home_trainer/app/screens/routines/screens/cyclingForm/services/cyclingController.dart';
import 'package:home_trainer/app/screens/routines/utilities/cancelRoutineMessage.dart';

class CyclingFormPage extends StatefulWidget {
  @override
  _CyclingFormPageState createState() => _CyclingFormPageState();
}

class _CyclingFormPageState extends State<CyclingFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            cancelRoutineMessage(context);
          },
        ),
        title: Center(child: Text('create cyling routine')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: CyclingFormController(),
        ),
      ),
    );
  }
}
