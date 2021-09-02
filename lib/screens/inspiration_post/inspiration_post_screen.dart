import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/inspiration_post/components/body.dart';

class InspirationPostScreen extends StatelessWidget {
  static String routeName = "/inspirationpost";

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Body());
  }
}
