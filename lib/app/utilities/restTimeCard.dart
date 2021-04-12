import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_trainer/app/screens/routines/utilities/roundIconButtone.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class RestTimeCard extends StatelessWidget {
  const RestTimeCard({
    this.labelText,
    this.cardColor,
    this.minutesLabelText,
    this.secondsLabelText,
    this.sizedBoxHeight,
    this.onPressedPlusMin,
    this.onPressedMinusMin,
    this.onPressedPlusSec,
    this.onPressedMinusSec,
  });

  final int minutesLabelText, secondsLabelText;
  final String labelText;
  final Color cardColor;
  final double sizedBoxHeight;
  final Function onPressedPlusMin;
  final Function onPressedMinusMin;
  final Function onPressedPlusSec;
  final Function onPressedMinusSec;

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
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Text(
                labelText,
                style: kTitleLabelTextStyle,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: sizedBoxHeight),
                    Text(
                      minutesLabelText < 10
                          ? '0${minutesLabelText.toString()}'
                          : minutesLabelText.toString(),
                      style: kRestTimeLabelTextStyle,
                    ),
                    SizedBox(height: sizedBoxHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundIconButton(
                          icon: FontAwesomeIcons.minus,
                          onPressed: onPressedMinusMin,
                        ),
                        SizedBox(width: 30.0),
                        RoundIconButton(
                          icon: FontAwesomeIcons.plus,
                          onPressed: onPressedPlusMin,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: Center(
                    child: Text(
                      ':',
                      style: TextStyle(
                        fontSize: 60,
                        color: kIconColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: sizedBoxHeight),
                    Text(
                      secondsLabelText < 10
                          ? '0${secondsLabelText.toString()}'
                          : secondsLabelText.toString(),
                      style: kRestTimeLabelTextStyle,
                    ),
                    SizedBox(height: sizedBoxHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundIconButton(
                          icon: FontAwesomeIcons.minus,
                          onPressed: onPressedMinusSec,
                        ),
                        SizedBox(width: 30.0),
                        RoundIconButton(
                          icon: FontAwesomeIcons.plus,
                          onPressed: onPressedPlusSec,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
