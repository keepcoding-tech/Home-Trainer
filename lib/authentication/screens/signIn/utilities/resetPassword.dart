import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';
import 'package:provider/provider.dart';

import 'package:home_trainer/authentication/utilities/validation.dart';
import 'package:home_trainer/authentication/services/authenticationController.dart';

Future<void> showResetPassword(BuildContext context) {
  final TextEditingController controller = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: kActiveCardColor,
        title: Text(
          'Enter an email to reset your password',
          style: kContentLabelTextStyle,
        ),
        content: Container(
          child: Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              style: kAuthenticationTextFormFieldStyle,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 15.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: kTextFieldBorderColor,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: kTextFieldBorderColor,
                    width: 2.0,
                  ),
                ),
                labelStyle: kAuthenticationTextFormFieldStyle,
                suffixIcon: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.paperPlane,
                    color: kIconColor,
                  ),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      context
                          .read<AuthenticationController>()
                          .resetPassword(email: controller.text.trim());
                      Navigator.of(context).pop();
                    }
                  },
                ),
                labelText: 'email',
              ),
              validator: Validation().emailValidator(),
            ),
          ),
        ),
      );
    },
  );
}
