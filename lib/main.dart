import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/routes.dart';
import 'package:flutter_unity_widget_example/screens/splash/splash_screen.dart';
import 'package:flutter_unity_widget_example/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Unity Demo',
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
