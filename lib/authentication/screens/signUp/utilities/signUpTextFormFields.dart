import 'package:flutter/material.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class SignUpTextFormFields extends StatelessWidget {
  SignUpTextFormFields(
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
            labelText: labelText,
          ),
          validator: validator,
        ),
      ),
    );
  }
}
