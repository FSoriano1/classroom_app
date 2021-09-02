import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/constants.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

String title = "Loading...";
String image;
String user;
String desc = "Loading description...";
String proj;
String liked;

void pushPostData(String t, String i, String d, String p) {
  title = t;
  image = i;
  desc = d;
  proj = p;
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _alreadyLiked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$title",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionalScreenWidth(28),
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Container(
          margin:
              EdgeInsets.symmetric(horizontal: getProportionalScreenWidth(20)),
          padding: EdgeInsets.symmetric(
              horizontal: getProportionalScreenWidth(20),
              vertical: getProportionalScreenHeight(15)),
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.4,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20)),
        ),
        Row(
          children: [
            SizedBox(width: getProportionalScreenWidth(20)),
            IconButton(
                splashRadius: 25,
                icon: _alreadyLiked
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_outline, color: Colors.black),
                onPressed: () {
                  setState(() {
                    _alreadyLiked = !_alreadyLiked;
                  });
                }),
            IconButton(
                splashRadius: 25,
                icon: Icon(Icons.mode_comment_outlined, color: Colors.black),
                onPressed: () {}),
          ],
        ),
        Text("$desc",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionalScreenWidth(18),
            )),
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        SizedBox(
          width: SizeConfig.screenWidth * 0.4,
          height: getProportionalScreenHeight(50),
          child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {},
            child: Text("View Project",
                style: TextStyle(
                    fontSize: getProportionalScreenWidth(18),
                    color: Colors.white)),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.03),
        SizedBox(
          width: SizeConfig.screenWidth * 0.4,
          height: getProportionalScreenHeight(50),
          child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {},
            child: Text("Save",
                style: TextStyle(
                    fontSize: getProportionalScreenWidth(18),
                    color: Colors.white)),
          ),
        ),
        /*SizedBox(
            width: getProportionalScreenWidth(238),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(image)
            ))*/
      ],
    );
  }
}
