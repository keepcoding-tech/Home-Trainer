import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class EditTextFormField extends StatefulWidget {
  final String labelText, defaultData;
  final formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  EditTextFormField({this.labelText, this.defaultData});

  @override
  _EditTextFormFieldState createState() => _EditTextFormFieldState();
}

class _EditTextFormFieldState extends State<EditTextFormField> {
  @override
  Widget build(BuildContext context) {
    widget.controller.text = widget.defaultData;

    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: kActiveCardColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Form(
        key: widget.formKey,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: TextFormField(
            controller: widget.controller,
            style: kRoutineTextFormFieldStyle,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 15.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: kTextFieldBorderColor, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: kTextFieldBorderColor, width: 2),
              ),
              labelStyle: kRoutineTextFormFieldStyle,
              labelText: widget.labelText,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'a $widget.labelText is requaierd';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
