import 'package:flutter/material.dart';

import '../size_config.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    Key key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionalScreenWidth(10)),
        padding: EdgeInsets.all(getProportionalScreenWidth(12)),
        height: getProportionalScreenHeight(40),
        width: getProportionalScreenWidth(40),
        decoration:
            BoxDecoration(color: Color(0xFFF5F6F9), shape: BoxShape.circle),
        /*child: SvgPicture.asset(icon)*/
      ),
    );
  }
}
