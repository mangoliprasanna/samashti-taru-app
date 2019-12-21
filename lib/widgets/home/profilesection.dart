import 'package:flutter/material.dart';
import 'package:samashti_app/models/user_model.dart';

class HomeProfileWidget extends StatelessWidget {
  UserModel currentUser;
  HomeProfileWidget({
    @required this.currentUser,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Theme.of(context).accentColor,
      width: MediaQuery.of(context).size.width,
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed("/profile", arguments: currentUser);
        },
        title: Text(
          currentUser.userName,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.network(currentUser.userProfile),
        ),
        subtitle: Text(
          currentUser.userEmail,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
