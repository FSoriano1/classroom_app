import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/constants.dart';
import 'package:flutter_unity_widget_example/screens/unity_portion/simple_screen.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

String title = "Loading...";
String image;

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionalScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text("$title",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionalScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                "Insert image below",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: getProportionalScreenWidth(20)),
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionalScreenWidth(20),
                    vertical: getProportionalScreenHeight(15)),
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              SizedBox(
                width: SizeConfig.screenWidth * 0.5,
                height: getProportionalScreenHeight(56),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, SimpleScreen.routeName);
                  },
                  child: Text("LAUNCH",
                      style: TextStyle(
                          fontSize: getProportionalScreenWidth(18),
                          color: Colors.white)),
                ),
              ),
              SizedBox(height: getProportionalScreenHeight(20)),
              //start
              SizedBox(
                width: SizeConfig.screenWidth * 0.5,
                height: getProportionalScreenHeight(56),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                                title: Text('Delete project?'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Cancel');
                                      },
                                      child: const Text('Cancel')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                        //delete project from database and update the list tiles
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'))
                                ]));
                  },
                  child: Text("Delete Project",
                      style: TextStyle(
                          fontSize: getProportionalScreenWidth(18),
                          color: Colors.white)),
                ),
              ), //end
            ],
          ),
        ),
      ),
    ));
  }
}

void pushProjectData(String t, String i) {
  title = t;
  image = i;
}
