import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/home/components/scrapbook_button.dart';
import 'package:flutter_unity_widget_example/screens/home/components/wishlist_button.dart';
import 'package:flutter_unity_widget_example/size_config.dart';
import 'design_button.dart';
import 'inspiration_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
            child: Column(
      children: [
        SizedBox(height: getProportionalScreenHeight(10)),
        /*Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionalScreenWidth(20)),
          child: Row(children: [
            Text("CLASSROOM BY DESIGN",
                style: TextStyle(
                    fontSize: getProportionalScreenWidth(25),
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold)),
          ]),
        ),*/
        SizedBox(height: getProportionalScreenHeight(30)),
        DesignButton(),
        SizedBox(height: getProportionalScreenHeight(30)),
        Row(
          children: [InspirationButton(), ScrapbookButton()],
        ),
        SizedBox(height: getProportionalScreenHeight(50)),
        WishlistButton()
      ],
    )));
  }
}
