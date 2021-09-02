import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class InspirationCard extends StatelessWidget {
  const InspirationCard({
    Key key,
    @required this.title,
    @required this.description,
    @required this.press,
  }) : super(key: key);

  //final String image;
  final String title;
  final String description;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionalScreenWidth(12)),
        width: SizeConfig.screenWidth * 0.4,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.screenWidth * 0.4,
              width: SizeConfig.screenWidth * 0.4,
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
                        color: kPrimaryColor.withOpacity(0.5)),
                  ]),
              child: Row(
                children: <Widget>[
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "$title\n",
                        style: Theme.of(context).textTheme.button),
                    TextSpan(
                      text: description,
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
