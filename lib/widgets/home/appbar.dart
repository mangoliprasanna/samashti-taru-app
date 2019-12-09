import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samashti_app/helpers/theme_provider.dart';
import 'package:samashti_app/helpers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonAppBarItems extends StatelessWidget {
  List<AppBarItem> itemList = new List();
  UserProvider currentUser;

  _logoutUser(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(await pref.clear()){
      currentUser.deleteUser();
    }
    Navigator.of(context).pushReplacementNamed("/");
  }
  
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    currentUser = Provider.of<UserProvider>(context);
    itemList.clear();
    itemList.add(AppBarItem("Profile", 0));
    itemList.add(AppBarItem(
        theme.isDarkTheme ? "Light Mode" : "Dark Mode", theme.isDarkTheme ? 1 : 2));
    itemList.add(AppBarItem("Logout", 3));
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            
          },
        ),
        PopupMenuButton<AppBarItem>(
          onSelected: (d){

            if(d.functionId == 0)
              Navigator.of(context).pushNamed("/profile");

            if(d.functionId == 1)
              theme.setLightTheme();

            if(d.functionId == 2)
              theme.setDarkTheme();

            if(d.functionId == 3)
              _logoutUser(context);

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
