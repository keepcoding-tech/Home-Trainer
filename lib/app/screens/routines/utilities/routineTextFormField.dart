import 'package:flutter/material.dart';

const kTextFormFieldColor = Colors.blueGrey;

class RoutineTextFormField extends StatelessWidget {
  final TextEditingController controller = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  final String labelText;
  RoutineTextFormField({this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[600],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: controller,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 15.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
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
