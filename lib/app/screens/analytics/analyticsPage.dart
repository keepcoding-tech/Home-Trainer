import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(
              FontAwesomeIcons.sync,
              color: kIconColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: AnalyticsController(),
      ),
    );
  }
}
