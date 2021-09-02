import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/inspiration/inspiration_screen.dart';

import '../../../size_config.dart';

class InspirationButton extends StatelessWidget {
  const InspirationButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionalScreenWidth(20)),
      child: SizedBox(
          width: getProportionalScreenWidth(160),
          height: getProportionalScreenHeight(170),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, InspirationScreen.routeName),
                child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFA500),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionalScreenWidth(20),
                          vertical: getProportionalScreenHeight(15)),
                      child: Text.rich(TextSpan(
                          text: "Explore amazing classroom ideas!\n",
                          style: TextStyle(color: Colors.white),
                          children: [
                            TextSpan(
                                text: "GET INSPIRED",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ))
                          ])),
                    )),
              ))),
    );
  }
}
