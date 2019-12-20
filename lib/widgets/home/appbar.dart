import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonAppBarItems extends StatelessWidget {
  List<AppBarItem> itemList = new List();
  var currentUser;

  _logoutUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushReplacementNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    itemList.clear();
    itemList.add(AppBarItem(true ? "Light Mode" : "Dark Mode", true ? 1 : 2));
    itemList.add(AppBarItem("Logout", 3));
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
        PopupMenuButton<AppBarItem>(
          onSelected: (d) {
            if (d.functionId == 1) {
              DynamicTheme.of(context).setBrightness(
                Theme.of(context).brightness == Brightness.dark
                    ? Brightness.light
                    : Brightness.dark,
              );
            }
            if (d.functionId == 3) _logoutUser(context);
          },
          itemBuilder: (BuildContext context) {
            return itemList.map((f) {
              return PopupMenuItem<AppBarItem>(
                value: f,
                child: Text(f.text),
              );
            }).toList();
          },
        )
      ],
    );
  }
}

class AppBarItem {
  String text;
  int functionId;
  AppBarItem(this.text, this.functionId);
}
