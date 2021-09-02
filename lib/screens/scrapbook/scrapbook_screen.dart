import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/constants.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class ScrapbookScreen extends StatelessWidget {
  static String routeName = "/scrapbook";
  const ScrapbookScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0, length: 2, child: Scaffold(appBar: buildAppBar()));
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      title: Text("CLASSROOM BY DESIGN",
          style: TextStyle(
              fontSize: getProportionalScreenWidth(22),
              color: Colors.white,
              fontWeight: FontWeight.bold)),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.notifications_none),
            color: Colors.white,
            onPressed: () {})
      ],
      bottom: const TabBar(tabs: <Widget>[
        Tab(
          text: "Saved Projects",
        ),
        Tab(
          text: "Liked Ideas",
        ),
      ]),
    );
  }
}
