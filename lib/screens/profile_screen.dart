import 'package:flutter/material.dart';
import 'package:samashti_app/models/user_model.dart';
import 'package:samashti_app/screens/editprofile_screen.dart';

class ProfileScreen extends StatefulWidget {
  UserModel currentUser;
  ProfileScreen({@required this.currentUser, Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  _mediaSelectionDialog() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Make a choice!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              onTap: () {},
              leading: Icon(Icons.camera_alt),
              title: Text("Camera"),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.photo_library),
              title: Text("Gallery"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Profile"),
        elevation: 0,
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
                    child: _buildUserProfile(context),
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
              child: EditProfileWidget(currentUser: widget.currentUser,),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      padding: EdgeInsets.only(left: 12.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            widget.currentUser.userProfile,
          ),
        ),
      ),
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: _mediaSelectionDialog,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
