import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samashti_app/helpers/user_provider.dart';
import 'package:samashti_app/widgets/home/profilesection.dart';
import 'package:samashti_app/widgets/post/post.dart';

class HomwWidget extends StatefulWidget {
  HomwWidget({Key key}) : super(key: key);

  @override
  _HomwWidgetState createState() => _HomwWidgetState();
}

class _HomwWidgetState extends State<HomwWidget> {
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
  const WelcomeUser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HomeProfileWidget(user: user),
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