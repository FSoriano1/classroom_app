import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/wishlist/components/body.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class WishlistScreen extends StatelessWidget {
  static String routeName = "/wishlist";
  const WishlistScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: Body());
  }

  AppBar buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      backgroundColor: Colors.grey,
      title: Text("WISHLIST",
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
