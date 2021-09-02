import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/design/components/body.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class DesignScreen extends StatelessWidget {
  static String routeName = "/design";
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: Body());
  }

  AppBar buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      backgroundColor: Color(0xFF4A3298),
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
    );
  }
}
