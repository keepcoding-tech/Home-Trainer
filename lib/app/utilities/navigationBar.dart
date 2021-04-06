import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class NavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function selectTab;
  NavigationBar({this.currentIndex, this.selectTab});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      notchMargin: 5,
      child: BottomNavigationBar(
        unselectedItemColor: kIconColor,
        fixedColor: kBottomNavigationIconColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.running),
            backgroundColor: kPrimariColor,
            label: 'ROUTINES',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.calendarDay),
            backgroundColor: kPrimariColor,
            label: 'SCHEDULE',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.chartPie),
            backgroundColor: kPrimariColor,
            label: 'ANALYTICS',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userAlt),
            backgroundColor: kPrimariColor,
            label: 'PROFILE',
          ),
        ],
        onTap: selectTab,
      ),
    );
  }
}
