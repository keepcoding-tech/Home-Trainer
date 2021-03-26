import 'package:flutter/material.dart';

class ProgramsPage extends StatefulWidget {
  final String pageName = 'Programs page';

  @override
  _ProgramsPageState createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programs page'),
      ),
    );
  }
}
