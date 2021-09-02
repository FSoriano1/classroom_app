import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/scrapbook/scrapbook_screen.dart';
import '../../../size_config.dart';

class ScrapbookButton extends StatelessWidget {
  const ScrapbookButton({
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
                    Navigator.pushNamed(context, ScrapbookScreen.routeName),
                child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3CB371),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionalScreenWidth(20),
                          vertical: getProportionalScreenHeight(15)),
                      child: Text.rich(TextSpan(
                          text: "Saved Designs and Liked Ideas\n",
                          style: TextStyle(color: Colors.white),
                          children: [
                            TextSpan(
                                text: "MY SCRAPBOOK",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ))
                          ])),
                    )),
              ))),
    );
  }
}
