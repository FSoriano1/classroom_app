import 'package:flutter/material.dart';
import 'package:flutter_unity_widget_example/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_unity_widget_example/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SettingsMenu(
        icon: Icon(
          Icons.account_box,
          color: Colors.grey,
        ),
        text: 'Account',
        press: () {},
      ),
      SettingsMenu(
        icon: Icon(
          Icons.notifications,
          color: Colors.grey,
        ),
        text: 'Notifications',
        press: () {},
      ),
      SettingsMenu(
        icon: Icon(
          Icons.support,
          color: Colors.grey,
        ),
        text: 'Help',
        press: () {},
      ),
      SettingsMenu(
        icon: Icon(
          Icons.exit_to_app,
          color: Colors.grey,
        ),
        text: 'Log out',
        press: () {
          Navigator.pushNamed(context, SignInScreen.routeName);
        },
      )
    ]);
  }
}

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Color(0xFFF5F6F9),
              padding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: press,
          child: Row(
            children: [
              icon,
              SizedBox(width: 20),
              Expanded(
                  child: Text(text,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionalScreenWidth(18))))
            ],
          )),
    );
  }
}
