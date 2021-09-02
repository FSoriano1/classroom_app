import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/constants.dart';
import 'package:flutter_unity_widget_example/screens/profile/profile_screen.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(bottom: getProportionalScreenHeight(5)),
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
                SizedBox(
                  height: getProportionalScreenHeight(30),
                ),
                buildTextField("Profile Name", "Current Name"),
                buildTextField("Email", "user@gmail.com"),
                buildTextField("Bio", "Insert Bio Here"),
                SizedBox(height: getProportionalScreenHeight(30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ProfileScreen.routeName);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize: getProportionalScreenWidth(16),
                            letterSpacing: 1.5,
                            color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(width: getProportionalScreenWidth(40)),
                    ElevatedButton(
                      onPressed: () {
                        //update database
                        Navigator.pushNamed(context, ProfileScreen.routeName);
                      },
                      child: Text("Save",
                          style: TextStyle(
                              fontSize: getProportionalScreenWidth(16),
                              letterSpacing: 1.5,
                              color: Colors.white)),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                labelText: labelText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: placeholder,
                hintStyle: TextStyle(
                    fontSize: getProportionalScreenWidth(16),
                    fontWeight: FontWeight.bold,
                    color: Colors.grey))));
  }
}
