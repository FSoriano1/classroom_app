import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/design/project/components/body.dart';

class ProjectScreen extends StatelessWidget {
  static String routeName = "/project";

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Body());
  }
}
