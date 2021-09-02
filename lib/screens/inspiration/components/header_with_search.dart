import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class HeaderWithSearch extends StatelessWidget {
  const HeaderWithSearch({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: getProportionalScreenHeight(10)),
      height: SizeConfig.screenHeight * 0.15,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: getProportionalScreenWidth(20),
                bottom: getProportionalScreenHeight(40)),
            height: SizeConfig.screenHeight * 0.1,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36))),
            child: Row(
              children: <Widget>[
                Text(
                  "Get Inspired",
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
                          color: kPrimaryColor.withOpacity(0.4))
                    ]),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle:
                            TextStyle(color: kPrimaryColor.withOpacity(0.7)),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: kPrimaryColor,
                            ),
                            onPressed: () {
                              //search for post with keywords
                            }))),
              ))
        ],
      ),
    );
  }
}
