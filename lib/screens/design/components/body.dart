import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/design/components/constants.dart';
import 'package:flutter_unity_widget_example/screens/design/components/project_card.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool update = false;
  String msg = null;
  final msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Widget> itemsData = getProjectData(msg);

    return Column(
      children: [
        HeaderWithSearch(context),
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

  Container HeaderWithSearch(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: getProportionalScreenHeight(10)),
      height: SizeConfig.screenHeight * 0.15,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: getProportionalScreenWidth(20),
                bottom: getProportionalScreenHeight(50)),
            height: SizeConfig.screenHeight * 0.1,
            decoration: BoxDecoration(
                color: Color(0xFF4A3298),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36))),
            child: Row(
              children: <Widget>[
                Text(
                  "Your Projects",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer()
              ],
            ),
          ),
          Positioned(
              bottom: getProportionalScreenWidth(10),
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: getProportionalScreenWidth(20)),
                height: SizeConfig.screenHeight * 0.08,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 7),
                          blurRadius: 20,
                          color: Color(0xFF4A3298).withOpacity(0.4))
                    ]),
                child: TextField(
                    controller: msgController,
                    decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                            color: Color(0xFF4A3298).withOpacity(0.7)),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Color(0xFF4A3298),
                            ),
                            onPressed: () {
                              setState(() {
                                msg = msgController.text;
                              });
                              //search for post with keywords
                            }))),
              ))
        ],
      ),
    );
  }
}

List<Widget> getProjectData(String msg) {
  List<dynamic> responseList = PROJECT_DATA;
  bool changed = false;
  if (msg != null) {
    changed = true;
    msg = msg.toLowerCase();
  }
  List<Widget> listProjects = [];
  if (!changed) {
    for (var i = 0; i < responseList.length; i++) {
      listProjects.add(Column(
        children: [
          ProjectCard(
            title: responseList[i]["title"],
            image: responseList[i]["image"],
            press: () {},
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.03,
          ),
        ],
      ));
    }
  } else {
    for (var i = 0; i < responseList.length; i++) {
      if (responseList[i]["title"].toLowerCase().contains(msg)) {
        listProjects.add(Column(
          children: [
            ProjectCard(
              title: responseList[i]["title"],
              image: responseList[i]["image"],
              press: () {},
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.03,
            ),
          ],
        ));
      }
    }
  }
  return listProjects;
}
