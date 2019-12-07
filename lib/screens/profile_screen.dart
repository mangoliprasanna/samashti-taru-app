import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samashti_app/helpers/user_provider.dart';
import 'package:samashti_app/widgets/post/item/post.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/editprofile");
            },
            icon: Icon(Icons.edit),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(200.0),
                      ),
                    ),
                    height: 120,
                  ),
                  Positioned(
                    bottom: 5,
                    child: Hero(
                      tag: "profile-image",
                      child: Container(
                        padding: EdgeInsets.only(left: 12.0),
                        child: FadeInImage(
                          height: 150,
                          placeholder: AssetImage("assets/brand.png"),
                          image: NetworkImage(user.currentUser.userProfile),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                user.currentUser.userName,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                user.currentUser.userEmail,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Your Posts"),
            ),
            PostItem(),
            PostItem(),
            PostItem(),
          ],
        ),
      ),
    );
  }
}
