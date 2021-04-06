import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/screens/gymForm/services/gymFormController.dart';
import 'package:home_trainer/app/screens/routines/utilities/routineAppBar.dart';

class GymFormPage extends StatefulWidget {
  @override
  _GymFormPageState createState() => _GymFormPageState();
}

class _GymFormPageState extends State<GymFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DismissAppBar(messageTitle: 'Dismiss routine', title: 'GYM'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: GymFormController(),
            ),
          ),
        ),
      ),
    );
  }
}
