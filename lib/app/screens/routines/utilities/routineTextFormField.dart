import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class RoutineTextFormField extends StatelessWidget {
  final TextEditingController controller = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  final String labelText;
  RoutineTextFormField({this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: kActiveCardColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: TextFormField(
              controller: controller,
              style: kRoutineTextFormFieldStyle,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 15.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: kTextFieldBorderColor, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: kTextFieldBorderColor, width: 2),
                ),
                labelStyle: kRoutineTextFormFieldStyle,
                labelText: labelText,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'a $labelText is requaierd';
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }
}
