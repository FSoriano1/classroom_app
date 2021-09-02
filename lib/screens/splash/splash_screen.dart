import 'package:flutter_unity_widget_example/size_config.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    SizeConfig()
        .init(context); // SizeConfig must be called on the starting screen
    return Scaffold(body: Body());
  }
}
