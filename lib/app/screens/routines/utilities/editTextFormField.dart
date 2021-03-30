import 'package:flutter/material.dart';

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
      margin: EdgeInsets.all(15.0),
      child: Form(
        key: widget.formKey,
        child: TextFormField(
          controller: widget.controller,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.0),
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'a $widget.labelText is requaierd';
            }
            return null;
          },
        ),
      ),
    );
  }
}
