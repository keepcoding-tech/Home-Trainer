import 'package:flutter/material.dart';

class AnalyticsPage extends StatefulWidget {
  final String pageName = 'Programs page';

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics page'),
      ),
    );
  }
}
