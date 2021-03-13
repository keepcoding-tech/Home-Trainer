import 'package:flutter/material.dart';

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
            title: Text('Terms & Conditions'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('This are the terms and conditions'),
                  Text('This are the terms and conditions'),
                  Text('This are the terms and conditions'),
                  Text('This are the terms and conditions'),
                  Text('This are the terms and conditions'),
                  Text('This are the terms and conditions'),
                  Text('This are the terms and conditions'),
                  Text('This are the terms and conditions'),
                  Text('This are the terms and conditions'),
                  Text('This are the terms and conditions'),
                  Text('This are the terms and conditions'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
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
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            GestureDetector(
              child: Text(
                'Terms',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                _showTermsAndCondition();
              },
            ),
            Text(
              ' and ',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            GestureDetector(
              child: Text(
                'Privacy Notice.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
