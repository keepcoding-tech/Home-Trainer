import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class TermsAndConditions extends StatefulWidget {
  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  Future<void> _showTermsAndCondition() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: kActiveCardColor,
            title: Text(
              'Terms & Conditions',
              style: kSubtitleLabelTextStyle,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'This are the terms and conditions',
                    style: kContentLabelTextStyle,
                  ),
                  Text(
                    'This are the terms and conditions',
                    style: kContentLabelTextStyle,
                  ),
                  Text(
                    'This are the terms and conditions',
                    style: kContentLabelTextStyle,
                  ),
                  Text(
                    'This are the terms and conditions',
                    style: kContentLabelTextStyle,
                  ),
                  Text(
                    'This are the terms and conditions',
                    style: kContentLabelTextStyle,
                  ),
                  Text(
                    'This are the terms and conditions',
                    style: kContentLabelTextStyle,
                  ),
                  Text(
                    'This are the terms and conditions',
                    style: kContentLabelTextStyle,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: kButtonLabelTextStyle,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'By proceeding, you agree to the ',
              style: kContentLabelTextStyle,
            ),
            GestureDetector(
              child: Text(
                'Terms',
                style: kBoldContentLabelTextStyle,
              ),
              onTap: () {
                _showTermsAndCondition();
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Text(
                'of Services',
                style: kBoldContentLabelTextStyle,
              ),
              onTap: () {
                _showTermsAndCondition();
              },
            ),
            Text(
              ' and ',
              style: kContentLabelTextStyle,
            ),
            GestureDetector(
              child: Text(
                'Privacy Notice.',
                style: kBoldContentLabelTextStyle,
              ),
              onTap: () {
                _showTermsAndCondition();
              },
            ),
          ],
        ),
      ],
    );
  }
}
