import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/inspiration/components/constants.dart';
import 'package:flutter_unity_widget_example/screens/inspiration_post/components/body.dart';
import 'package:flutter_unity_widget_example/screens/inspiration_post/inspiration_post_screen.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

import 'header_with_search.dart';
import 'inspiration_card.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    List<Widget> itemsData =
        getPostsData(context); //maybe create a class for item data?
    return Column(
      children: [
        HeaderWithSearch(),
        Expanded(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: itemsData.length,
                      itemBuilder: (context, index) {
                        return itemsData[index];
                      })
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/*
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> itemsData =
        getPostsData(context); //maybe create a class for item data?

    return Column(
      children: [
        HeaderWithSearch(),
        Expanded(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: itemsData.length,
                      itemBuilder: (context, index) {
                        return itemsData[index];
                      })
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}*/

List<Widget> getPostsData(BuildContext context) {
  List<dynamic> responseList = ITEM_DATA;
  List<Widget> listItems = [];
  for (var i = 0; i < responseList.length; i++) {
    if (i == responseList.length - 1) {
      listItems.add(Column(
        children: [
          InspirationCard(
            title: responseList[i]["title"],
            description: responseList[i]["desc"],
            press: () {
              pushPostData(responseList[i]["title"], responseList[i]["image"],
                  responseList[i]["desc"], responseList[i]["proj"]);
              Navigator.pushNamed(context, InspirationPostScreen.routeName);
            },
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.03,
          ),
        ],
      ));
    } else {
      listItems.add(Column(
        children: [
          InspirationCardRow(
            title1: responseList[i]["title"],
            description1: responseList[i]["desc"],
            press1: () {
              pushPostData(
                  responseList[i - 1][
                      "title"], //dont know why but it seems to add 1 to i inside the press function
                  responseList[i - 1]["image"],
                  responseList[i - 1]["desc"],
                  responseList[i - 1]["proj"]);
              Navigator.pushNamed(context, InspirationPostScreen.routeName);
            },
            title2: responseList[i + 1]["title"],
            description2: responseList[i + 1]["desc"],
            press2: () {
              pushPostData(responseList[i]["title"], responseList[i]["image"],
                  responseList[i]["desc"], responseList[i]["proj"]);
              Navigator.pushNamed(context, InspirationPostScreen.routeName);
            },
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.03,
          ),
        ],
      ));
      i++;
    }
  }
  return listItems;
}

class InspirationCardRow extends StatelessWidget {
  const InspirationCardRow({
    Key key,
    this.title1,
    this.description1,
    this.press1,
    this.title2,
    this.description2,
    this.press2,
  }) : super(key: key);

  final String title1;
  final String description1;
  final Function press1;
  final String title2;
  final String description2;
  final Function press2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InspirationCard(
          title: title1,
          description: description1,
          press: press1,
        ),
        InspirationCard(
          title: title2,
          description: description2,
          press: press2,
        ),
      ],
    );
  }
}
