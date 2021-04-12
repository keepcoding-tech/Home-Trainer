import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_trainer/app/screens/routines/utilities/roundIconButtone.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class UnitInputCard extends StatelessWidget {
  const UnitInputCard({
    @required this.labelText,
    @required this.inputText,
    @required this.cardColor,
    @required this.sizedBoxHeight,
    @required this.onPressedMinus,
    @required this.onPressedPlus,
  });

  final Text inputText;
  final String labelText;
  final Color cardColor;
  final double sizedBoxHeight;
  final Function onPressedMinus;
  final Function onPressedPlus;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Text(
                labelText,
                style: kTitleLabelTextStyle,
              ),
            ),
          ),
          SizedBox(height: sizedBoxHeight),
          inputText,
          SizedBox(height: sizedBoxHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundIconButton(
                icon: FontAwesomeIcons.minus,
                onPressed: onPressedMinus,
              ),
              SizedBox(width: 30.0),
              RoundIconButton(
                icon: FontAwesomeIcons.plus,
                onPressed: onPressedPlus,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
