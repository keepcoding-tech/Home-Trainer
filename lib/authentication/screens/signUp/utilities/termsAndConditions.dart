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
                    'These terms and conditions set forth the general terms and conditions of your use of the "Home Trainer" mobile application and any of its related products and services. \n\n' +
                        'This Agreement is legally binding between you and this Mobile Application developer.' +
                        ' By accessing and using the Mobile Application and Services, you acknowledge that you have read, understood, and agree to be bound by the terms of this Agreement. \n\n' +
                        'If you are entering into this Agreement on behalf of a business or other legal entity, you represent that you have the authority to bind such entity to this Agreement,' +
                        ' in which case the terms "User", "you" or "your" shall refer to such entity. If you do not have such authority, or if you do not agree with the terms of this Agreement,' +
                        'you must not accept this Agreement and may not access and use the Mobile Application and Services. \n\n' +
                        'You acknowledge that this Agreement is a contract between you and the Operator, even though it is electronic and is not physically signed by you, and it governs your use of the Mobile Application and Services. \n\n',
                    style: kContentLabelTextStyle,
                  ),
                  Text(
                    'Accounts and membership \n',
                    style: kContentSubtitleLabelTextStyle,
                  ),
                  Text(
                    'If you create an account in the Mobile Application, you are responsible for maintaining the security of your account and you are fully responsible for all activities that occur under the account and any other actions taken in connection with it. \n\n' +
                        'We may, but have no obligation to, monitor and review new accounts before you may sign in and start using the Services. \n\n' +
                        'Providing false contact information of any kind may result in the termination of your account. You must immediately notify us of any unauthorized uses of your account or any other breaches of security. \n\n' +
                        'We will not be liable for any acts or omissions by you, including any damages of any kind incurred as a result of such acts or omissions. \n\n' +
                        'We may suspend, disable, or delete your account if we determine that you have violated any provision of this Agreement or that your conduct or content would tend to damage our reputation and goodwill. If we delete your account for the foregoing reasons, you may not re-register for our Services. \n\n' +
                        'We may block your email address and Internet protocol address to prevent further registration. \n\n',
                    style: kContentLabelTextStyle,
                  ),
                  Text(
                    'Changes and amendments \n',
                    style: kContentSubtitleLabelTextStyle,
                  ),
                  Text(
                    'We reserve the right to modify this Agreement or its terms relating to the Mobile Application and Services at any time, effective upon posting of an updated version of this Agreement in the Mobile Application. \n\n' +
                        'When we do, we will post a notification in the Mobile Application. \n\n' +
                        'Continued use of the Mobile Application and Services after any such changes shall constitute your consent to such changes. \n\n',
                    style: kContentLabelTextStyle,
                  ),
                  Text(
                    'Acceptance of these terms \n',
                    style: kContentSubtitleLabelTextStyle,
                  ),
                  Text(
                    'You acknowledge that you have read this Agreement and agree to all its terms and conditions. \n\n' +
                        'By accessing and using the Mobile Application and Services you agree to be bound by this Agreement. \n\n' +
                        'If you do not agree to abide by the terms of this Agreement, you are not authorized to access or use the Mobile Application and Services. \n\n',
                    style: kContentLabelTextStyle,
                  ),
                  Text(
                    'Contacting us \n',
                    style: kContentSubtitleLabelTextStyle,
                  ),
                  Text(
                    'If you would like to contact us to understand more about this Agreement or wish to contact us concerning any matter relating to it,' +
                        ' you may send an email to: \n\n' +
                        'tanasedaniel54@gmail.com. \n\n' +
                        'This document was last updated on: \n' +
                        '   April 12, 2021',
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
