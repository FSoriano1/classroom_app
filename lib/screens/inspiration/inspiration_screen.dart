import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/inspiration/components/body.dart';

import '../../constants.dart';
import '../../size_config.dart';

class InspirationScreen extends StatelessWidget {
  static String routeName = "/inspiration";
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: Body());
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
    );
  }
}
