import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/settings/components/body.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = "/settings";
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings',
              style: TextStyle(
                  fontSize: getProportionalScreenWidth(20),
                  color: Colors.black)),
          centerTitle: true,
        ),
        body: Body());
  }
}
