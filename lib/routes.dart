import 'package:flutter/widgets.dart';
import 'package:flutter_unity_widget_example/screens/design/design_screen.dart';
import 'package:flutter_unity_widget_example/screens/design/project/project_screen.dart';
import 'package:flutter_unity_widget_example/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter_unity_widget_example/screens/home/home_screen.dart';
import 'package:flutter_unity_widget_example/screens/inspiration/inspiration_screen.dart';
import 'package:flutter_unity_widget_example/screens/inspiration_post/inspiration_post_screen.dart';
import 'package:flutter_unity_widget_example/screens/profile/edit/editprofile_screen.dart';
import 'package:flutter_unity_widget_example/screens/profile/profile_screen.dart';
import 'package:flutter_unity_widget_example/screens/scrapbook/scrapbook_screen.dart';
import 'package:flutter_unity_widget_example/screens/settings/settings_screen.dart';
import 'package:flutter_unity_widget_example/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_unity_widget_example/screens/unity_portion/simple_screen.dart';
import 'package:flutter_unity_widget_example/screens/splash/splash_screen.dart';
import 'package:flutter_unity_widget_example/screens/wishlist/wishlist_screen.dart';

// all routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  InspirationScreen.routeName: (context) => InspirationScreen(),
  DesignScreen.routeName: (context) => DesignScreen(),
  ProjectScreen.routeName: (context) => ProjectScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  InspirationPostScreen.routeName: (context) => InspirationPostScreen(),
  WishlistScreen.routeName: (context) => WishlistScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
  EditProfileScreen.routeName: (context) => EditProfileScreen(),
  ScrapbookScreen.routeName: (context) => ScrapbookScreen(),
  SimpleScreen.routeName: (context) => SimpleScreen(),
};
