import 'package:flutter/material.dart';

import 'package:home_trainer/app/services/pageNavigator.dart';
import 'package:home_trainer/app/utilities/navigationBar.dart';

class NavigationController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NavigationControllerState();
}

class NavigationControllerState extends State<NavigationController> {
  int currentIndex = 3;
  String currentPage = 'profile';
  List<String> pageKeys = ['routines', 'shedule', 'analytics', 'profile'];

  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    'routines': GlobalKey<NavigatorState>(),
    'shedule': GlobalKey<NavigatorState>(),
    'analytics': GlobalKey<NavigatorState>(),
    'profile': GlobalKey<NavigatorState>(),
  };

  void _selectTab(String pageItem, int index) {
    if (pageItem == currentPage) {
      _navigatorKeys[pageItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentPage = pageKeys[index];
        currentIndex = index;
        NavigationBar();
      });
    }
  }

  Widget _buildOffstageNavigator(String pageItem) {
    return Offstage(
      offstage: currentPage != pageItem,
      child: PageNavigator(
        navigatorKey: _navigatorKeys[pageItem],
        pageItem: pageItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentPage =
            !await _navigatorKeys[currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentPage) {
          if (currentPage != 'profile') {
            _selectTab('profile', 3);
            return false;
          }
        }
        return isFirstRouteInCurrentPage;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildOffstageNavigator('routines'),
            _buildOffstageNavigator('shedule'),
            _buildOffstageNavigator('analytics'),
            _buildOffstageNavigator('profile'),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          currentIndex: currentIndex,
          selectTab: (index) {
            _selectTab(pageKeys[index], index);
          },
        ),
      ),
    );
  }
}
