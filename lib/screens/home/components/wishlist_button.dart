import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/wishlist/wishlist_screen.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class WishlistButton extends StatelessWidget {
  const WishlistButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, WishlistScreen.routeName),
      child: Container(
          margin:
              EdgeInsets.symmetric(horizontal: getProportionalScreenWidth(20)),
          padding: EdgeInsets.symmetric(
              horizontal: getProportionalScreenWidth(20),
              vertical: getProportionalScreenHeight(15)),
          width: double.infinity,
          height: getProportionalScreenHeight(75), //used to be just 60px
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: Text.rich(TextSpan(
              text: "Create a Wishlist to share with families\n",
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(
                    text: "WISHLIST",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ))
              ]))),
    );
  }
}
