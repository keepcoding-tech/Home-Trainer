import 'package:flutter/material.dart';
import 'package:home_trainer/app/screens/routines/screens/gymForm/services/gymFormController.dart';
import 'package:home_trainer/app/screens/routines/utilities/cancelRoutineMessage.dart';

class GymFormPage extends StatefulWidget {
  @override
  _GymFormPageState createState() => _GymFormPageState();
}

class _GymFormPageState extends State<GymFormPage> {
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
        title: Center(child: Text('Create gym routine')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GymFormController(),
        ),
      ),
    );
  }
}
