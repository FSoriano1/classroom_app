import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/constants.dart';
import 'package:flutter_unity_widget_example/screens/home/home_screen.dart';
import 'package:flutter_unity_widget_example/screens/profile/components/body.dart';
import 'package:flutter_unity_widget_example/screens/profile/edit/editprofile_screen.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(context), body: Body());
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, HomeScreen.routeName),
      ),
      title: Text("Profile",
          style: TextStyle(
              fontSize: getProportionalScreenWidth(20),
              fontWeight: FontWeight.bold,
              color: Colors.white)),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, EditProfileScreen.routeName);
            },
            child: Text("Edit",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionalScreenWidth(20))))
      ],
    );
  }

  /*AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white),onPressed: () => Navigator.pushNamed(context, DesignScreen.routeName),),
      title: Text("Profile",
          style: TextStyle(
              fontSize: getProportionalScreenWidth(20),
              fontWeight: FontWeight.bold,
              color: Colors.white)),
      actions: <Widget>[
        TextButton(
            onPressed: () {},
            child: Text("Edit",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionalScreenWidth(20))))
      ],
    );
  }*/
}
