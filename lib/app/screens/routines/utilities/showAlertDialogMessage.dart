import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

Future<void> showAlertDialogMessage({
  BuildContext context,
  String messageTitle,
  String messageDetails,
  Function onPressed,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: kInactiveCardColor,
        title: Text(messageTitle, style: kTitleLabelTextStyle),
        content: Text(messageDetails, style: kSubtitleLabelTextStyle),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onPressed();
            },
            child: Text('YES', style: kButtonLabelTextStyle),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('NO', style: kButtonLabelTextStyle),
          ),
        ],
      );
    },
  );
}
