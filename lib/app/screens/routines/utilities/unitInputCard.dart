import 'package:flutter/material.dart';
import 'package:home_trainer/app/screens/routines/utilities/roundIconButtone.dart';

class UnitInputCard extends StatefulWidget {
  const UnitInputCard({
    @required this.labelText,
    @required this.inputText,
    @required this.onPressedPlus,
    @required this.onPressedMinus,
  });

  final Text inputText;
  final String labelText;
  final Function onPressedPlus;
  final Function onPressedMinus;

  @override
  _UnitInputCardState createState() => _UnitInputCardState();
}

class _UnitInputCardState extends State<UnitInputCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[600],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Text(
                widget.labelText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              widget.inputText,
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RoundIconButton(
                    icon: Icons.remove,
                    onPressed: widget.onPressedMinus,
                  ),
                  SizedBox(width: 30.0),
                  RoundIconButton(
                    icon: Icons.add,
                    onPressed: widget.onPressedPlus,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
