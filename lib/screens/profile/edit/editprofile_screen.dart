import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/profile/edit/components/body.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class EditProfileScreen extends StatelessWidget {
  static String routeName = "/editprofile";
  const EditProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile',
            style: TextStyle(
                fontSize: getProportionalScreenWidth(20), color: Colors.black)),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
