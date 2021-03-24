import 'package:flutter/material.dart';

class RoutineTextFormField extends StatelessWidget {
  final TextEditingController controller = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  final String labelText;
  RoutineTextFormField({this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.0),
            labelText: labelText,
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'a $labelText is requaierd';
            }
            return null;
          },
        ),
      ),
    );
  }
}
