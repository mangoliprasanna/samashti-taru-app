import 'package:flutter/material.dart';
import 'package:samashti_app/helpers/user_provider.dart';

class HomeProfileWidget extends StatelessWidget {
  const HomeProfileWidget({
    Key key,
    @required this.user,
  }) : super(key: key);

  final UserProvider user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Theme.of(context).accentColor,
      width: MediaQuery.of(context).size.width,
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed("/profile");
        },
        title: Text(
          user.currentUser.userName,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: Hero(
          tag: "profile-image",
          child: Image.network(
            user.currentUser.userProfile,
          ),
        ),
        subtitle: Text(
          user.currentUser.userEmail,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
