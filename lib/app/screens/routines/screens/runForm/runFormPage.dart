import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/screens/runForm/services/runController.dart';
import 'package:home_trainer/app/screens/routines/utilities/cancelRoutineMessage.dart';

class RunFormPage extends StatefulWidget {
  @override
  _RunFormPageState createState() => _RunFormPageState();
}

class _RunFormPageState extends State<RunFormPage> {
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
        title: Center(child: Text('create run routine')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: RunFormController(),
        ),
      ),
    );
  }
}
