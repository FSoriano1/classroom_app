import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/sign_in/components/body.dart';
import 'package:flutter_unity_widget_example/screens/splash/splash_screen.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text("Sign In"),
            centerTitle: true,
            leading: BackButton(
              onPressed: () {
                Navigator.pushNamed(context, SplashScreen.routeName);
              },
            )),
        body: Body());
  }
}
