import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/components/no_account_text.dart';
import 'package:flutter_unity_widget_example/components/social_card.dart';
import 'package:flutter_unity_widget_example/screens/sign_in/components/sign_form.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionalScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text("Welcome Back!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionalScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                "Sign in with your email and password",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              SignForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(icon: "assetName", press: () {}),
                  SocialCard(icon: "assetName", press: () {}),
                  SocialCard(icon: "assetName", press: () {}),
                ],
              ),
              SizedBox(height: getProportionalScreenHeight(20)),
              NoAccountText(),
            ],
          ),
        ),
      ),
    ));
  }
}
