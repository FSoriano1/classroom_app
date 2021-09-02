import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/components/default_button.dart';
import 'package:flutter_unity_widget_example/constants.dart';
import 'package:flutter_unity_widget_example/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_unity_widget_example/screens/splash/components/splash_content.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: PageView.builder(
                    itemBuilder: (context, index) =>
                        SplashContent(text: "Welcome!"))),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionalScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    buildDot(),
                    Spacer(flex: 3),
                    DefaultButton(
                        text: "Continue",
                        press: () {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        }),
                    Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildDot() {
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: 6,
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(3)),
    );
  }
}
