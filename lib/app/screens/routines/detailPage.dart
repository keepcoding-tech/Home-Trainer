import 'package:flutter/material.dart';

import 'package:home_trainer/app/screens/routines/services/detailPageList.dart';
import 'package:home_trainer/app/screens/routines/utilities/detailsPageAppBar.dart';

class DetailPage extends StatefulWidget {
  final String title, sport;
  DetailPage({this.title, this.sport});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DetailsPageAppBar(routineTitle: widget.title),
      ),
      body: SafeArea(
        child: DetailPageList(
          routineTitle: widget.title,
          sport: widget.sport,
        ),
      ),
    );
  }
}
