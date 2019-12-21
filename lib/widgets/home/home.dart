import 'package:flutter/material.dart';
import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/models/user_model.dart';
import 'package:samashti_app/widgets/home/profilesection.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        WelcomeUser(),
      ],
    );
  }
}

class WelcomeUser extends StatelessWidget {
  WelcomeUser({Key key}) : super(key: key);
  UserModel currentUser = NetworkHelper.getInstance().getUser();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HomeProfileWidget(
          currentUser: currentUser,
        ),
        Container(
          color: Theme.of(context).accentColor,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.0),
                topRight: Radius.circular(35.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16, left: 32.0, bottom: 16.0),
                  child: Text(
                    "Latest Feed",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.title.color,
                        fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
