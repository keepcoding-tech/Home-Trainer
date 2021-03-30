import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/analytics/analyticsPage.dart';
import 'package:home_trainer/app/screens/profile/profilePage.dart';
import 'package:home_trainer/app/screens/routines/routinesPage.dart';
import 'package:home_trainer/app/screens/schedule/schedulePage.dart';

class PageNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String pageItem;

  PageNavigator({Key key, this.navigatorKey, this.pageItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (pageItem == 'routines') {
      child = RoutinesPage();
    } else if (pageItem == 'shedule') {
      child = SchedulePage();
    } else if (pageItem == 'analytics') {
      child = AnalyticsPage();
    } else if (pageItem == 'profile') {
      child = ProfilePage();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
