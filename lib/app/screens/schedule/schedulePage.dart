import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  final String pageName = 'Schedule page';

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule page'),
      ),
    );
  }
}
