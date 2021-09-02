import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/components/default_button.dart';
import 'package:flutter_unity_widget_example/components/form_error.dart';
import 'package:flutter_unity_widget_example/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter_unity_widget_example/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          buildEmailFormField(),
          SizedBox(height: getProportionalScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionalScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                  value: remember,
                  activeColor: kPrimaryColor,
                  onChanged: (value) {
                    setState(() {
                      remember = value;
                    });
                  }),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text("Forgot Password",
                    style: TextStyle(decoration: TextDecoration.underline)),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionalScreenHeight(20)),
          DefaultButton(
              text: "Sign In",
              press: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  // if everything is valid go to home screen
                  //get userID and data from database and if remember is true, keep user logged on in phone
                  Navigator.pushNamed(context, HomeScreen.routeName);
                }
              })
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        obscureText: true,
        onSaved: (newValue) => password = newValue,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kPassNullError)) {
            setState(() {
              errors.remove(kPassNullError);
            });
          } else if (value.length >= 8 && errors.contains(kShortPassError)) {
            setState(() {
              errors.remove(kShortPassError);
            });
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty && !errors.contains(kPassNullError)) {
            setState(() {
              errors.add(kPassNullError);
            });
            return "";
          } else if (value.length < 8 &&
              value.length != 0 &&
              !errors.contains(kShortPassError)) {
            setState(() {
              errors.add(kShortPassError);
            });
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "password",
          //floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kEmailNullError)) {
            setState(() {
              errors.remove(kEmailNullError);
            });
          } else if (emailValidatorRegExp.hasMatch(value) &&
              errors.contains(kInvalidEmailError)) {
            setState(() {
              errors.remove(kInvalidEmailError);
            });
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty && !errors.contains(kEmailNullError)) {
            setState(() {
              errors.add(kEmailNullError);
            });
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value) &&
              value.isNotEmpty &&
              !errors.contains(kInvalidEmailError)) {
            setState(() {
              errors.add(kInvalidEmailError);
            });
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "email",
          //floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }
}
