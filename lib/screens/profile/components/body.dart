import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/constants.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
            height: SizeConfig.screenHeight * 0.4,
            child: Stack(
              children: <Widget>[
                Container(
                  height: SizeConfig.screenHeight * 0.35,
                  color: kPrimaryColor,
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: getProportionalScreenHeight(10)),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: getProportionalScreenHeight(5)),
                        height: SizeConfig.screenHeight * 0.2,
                        width: SizeConfig.screenHeight * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white,
                                width: getProportionalScreenWidth(1))
                            //image: DecorationImage(fit: BoxFit.cover, image: AssetImage("image.png"))
                            ),
                      ),
                      SizedBox(height: getProportionalScreenHeight(20)),
                      Text("Profile Name",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(18),
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(height: getProportionalScreenHeight(15)),
                      Text("user@gmail.com",
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                )
              ],
            )),
        Text("Insert Bio here",
            style: TextStyle(
                color: Colors.black, fontSize: getProportionalScreenWidth(17)))
      ],
    );
  }
}
