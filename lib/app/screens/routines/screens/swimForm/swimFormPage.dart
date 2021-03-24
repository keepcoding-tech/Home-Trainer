import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/screens/swimForm/services/swimController.dart';
import 'package:home_trainer/app/screens/routines/utilities/cancelRoutineMessage.dart';

class SwimFormPage extends StatefulWidget {
  @override
  _SwimFormPageState createState() => _SwimFormPageState();
}

class _SwimFormPageState extends State<SwimFormPage> {
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
        title: Center(child: Text('create swim routine')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SwimFormController(),
        ),
      ),
    );
  }
}
