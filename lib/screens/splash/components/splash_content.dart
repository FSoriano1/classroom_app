import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({Key key, this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Text("CLASSROOM BY DESIGN",
              style: TextStyle(
                  fontSize: getProportionalScreenWidth(36),
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold)),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
          Spacer(flex: 2)
        ],
      ),
    );
  }
}
