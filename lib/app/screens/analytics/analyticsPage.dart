import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/analytics/services/analyticsController.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'ANALYTICS',
          style: kTitleLabelTextStyle,
        )),
      ),
      body: SafeArea(
        child: AnalyticsController(),
      ),
    );
  }
}
