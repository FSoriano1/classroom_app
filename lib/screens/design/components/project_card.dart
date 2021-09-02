import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/design/project/components/body.dart';
import 'package:flutter_unity_widget_example/screens/design/project/project_screen.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key key,
    @required this.title,
    @required this.image,
    @required this.press,
  }) : super(key: key);

  final String title;
  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushProjectData(title, image);
        Navigator.pushNamed(context, ProjectScreen.routeName);
      },
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionalScreenWidth(12)),
        width: SizeConfig.screenWidth * 0.8,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.screenHeight * 0.2,
              width: SizeConfig.screenWidth * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.3)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(getProportionalScreenHeight(10)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xFF4A3298).withOpacity(0.5)),
                  ]),
              child: Row(
                children: <Widget>[
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "$title\n",
                        style: Theme.of(context).textTheme.button),
                    TextSpan(
                      text: "INSERT IMAGE",
                      style: TextStyle(color: Colors.black.withOpacity(0.5)),
                    )
                  ]))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
