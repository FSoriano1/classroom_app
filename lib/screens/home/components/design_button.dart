import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/design/design_screen.dart';

import '../../../size_config.dart';

class DesignButton extends StatelessWidget {
  const DesignButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, DesignScreen.routeName),
      child: Container(
          margin:
              EdgeInsets.symmetric(horizontal: getProportionalScreenWidth(20)),
          padding: EdgeInsets.symmetric(
              horizontal: getProportionalScreenWidth(20),
              vertical: getProportionalScreenHeight(15)),
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
              color: Color(0xFF4A3298),
              borderRadius: BorderRadius.circular(20)),
          child: Text.rich(TextSpan(
              text: "Design your classroom in 3D\n",
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(
                    text: "DESIGN",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ))
              ]))),
    );
  }
}
