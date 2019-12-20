import 'package:flutter/material.dart';
import 'package:samashti_app/models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  UserModel currentUser;
  ProfileScreen({@required this.currentUser, Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(200.0),
                        bottomLeft: Radius.circular(200.0),
                      ),
                    ),
                    height: 120,
                  ),
                  Positioned(
                    bottom: 5,
                    child: Hero(
                      tag: "profile-image",
                      child: Container(
                        height: 150,
                        width: 150,
                        padding: EdgeInsets.only(left: 12.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                              "https://via.placeholder.com/150",
                            ),
                          ),
                        ),
                        
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                widget.currentUser.userName,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                widget.currentUser.userEmail,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Your Posts"),
            ),
          ],
        ),
      ),
    );
  }
}
