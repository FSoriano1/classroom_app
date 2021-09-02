import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/home/components/body.dart';
import 'package:flutter_unity_widget_example/screens/profile/profile_screen.dart';
import 'package:flutter_unity_widget_example/screens/settings/settings_screen.dart';
import 'package:flutter_unity_widget_example/screens/sign_in/sign_in_screen.dart';

import '../../constants.dart';
import '../../size_config.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      drawer: CustomDrawer(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text("CLASSROOM BY DESIGN",
          style: TextStyle(
              fontSize: getProportionalScreenWidth(22),
              color: kPrimaryColor,
              fontWeight: FontWeight.bold)),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.notifications_none), onPressed: () {})
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        Container(
          height: SizeConfig.screenHeight * 0.1,
          child: DrawerHeader(
            child: Text(""),
            margin: const EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(color: kPrimaryColor),
          ),
        ),
        ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Profile"),
            onTap: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            }),
        ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            }),
        ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Log Out"),
            onTap: () {
              Navigator.pushNamed(context, SignInScreen.routeName);
            })
      ],
    ));
  }
}
