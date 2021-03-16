import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm(
      {this.labelText, this.inputType, this.obscureText, this.validator});
  final Function validator;
  final TextInputType inputType;
  final bool obscureText;
  final String labelText;

  final TextEditingController controller = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          keyboardType: inputType,
          obscureText: obscureText,
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
          validator: validator,
        ),
      ),
    );
  }
}
