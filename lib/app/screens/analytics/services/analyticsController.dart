import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:home_trainer/database/usersDatabaseController.dart';

DocumentSnapshot snapshot;

class AnalyticsController extends StatefulWidget {
  @override
  _AnalyticsControllerState createState() => _AnalyticsControllerState();
}

class _AnalyticsControllerState extends State<AnalyticsController> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    List<FlSpot> analyticsDataList = <FlSpot>[];

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(currentUser.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          if (data['analyticData'].length > 11) {
            List<dynamic> newList = data['analyticData'];
            newList.removeAt(0);

            UserDatabaseController(uid: currentUser.uid)
                .deleteUserInfoGeneticsData(newList);
          }
          for (var index = 0; index < data['analyticData'].length; index++) {
            analyticsDataList.add(
              FlSpot(index.toDouble(), data['analyticData'][index].toDouble()),
            );
          }

          return Container(
            decoration: BoxDecoration(
              color: kInactiveCardColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
            height: double.infinity,
            width: double.infinity,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 10,
                minY: 0,
                maxY: 35,
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    barWidth: 3.5,
                    colors: <Color>[kButtonColor],
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      colors: <Color>[kButtonColor]
                          .map((color) => color.withOpacity(0.2))
                          .toList(),
                    ),
                    spots: analyticsDataList.length == 0
                        ? <FlSpot>[FlSpot(0, 17.5)]
                        : analyticsDataList,
                  ),
                ],
              ),
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}
