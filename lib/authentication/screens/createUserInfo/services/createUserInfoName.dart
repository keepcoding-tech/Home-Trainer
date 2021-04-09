import 'package:flutter/material.dart';

import 'package:home_trainer/authentication/screens/createUserInfo/services/createUserInfoGeneticsData.dart';
import 'package:home_trainer/authentication/screens/signIn/utilities/signInTextFormFields.dart';
import 'package:home_trainer/authentication/utilities/validation.dart';
import 'package:home_trainer/app/utilities/constantsStyles.dart';

class CreateUserInfoName extends StatelessWidget {
  final String email, password, authMethod;
  CreateUserInfoName({this.email, this.password, this.authMethod});

  final SignInTextFormFields _firstNameForm = SignInTextFormFields(
    labelText: 'first name',
    inputType: TextInputType.text,
    obscureText: false,
    validator: Validation().nameValidator(),
  );

  final SignInTextFormFields _lastNameForm = SignInTextFormFields(
    labelText: 'last name',
    inputType: TextInputType.text,
    obscureText: false,
    validator: Validation().nameValidator(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          // first name form
          _firstNameForm,
          SizedBox(height: 10.0),
          // last name form
          _lastNameForm,
          SizedBox(height: 10.0),
          // continue button
          MaterialButton(
            minWidth: double.infinity,
            color: kIconColor,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              'CONTINUE',
              style: TextStyle(
                color: kLightBackgroundColor,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              if (_firstNameForm.formKey.currentState.validate()) {
                if (_lastNameForm.formKey.currentState.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateUserInfoGeneticsData(
                        fullName:
                            '${_firstNameForm.controller.text.trim()} ${_lastNameForm.controller.text.trim()}',
                        email: email,
                        password: password,
                        authMethod: authMethod,
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
