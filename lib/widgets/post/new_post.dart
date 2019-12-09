import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/helpers/user_provider.dart';

class NewPost extends StatefulWidget {
  NewPost({Key key}) : super(key: key);

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  UserProvider user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image.network(
                  user.currentUser.userProfile,
                  width: 50,
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.currentUser.userName,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        autocorrect: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                            border: InputBorder.none,
                            hintText: 'What\'s happening? ',
                            hintStyle: TextStyle(fontSize: 20.0)),
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            onPressed: () async {
              var cameraImage = await ImagePicker.pickImage(source: ImageSource.camera);
              if(cameraImage != null)
                NetworkHelper.getInstance().uploadMedia(cameraImage.path);
            },
            icon: Icon(Icons.camera_alt),
          ),
          IconButton(
            onPressed: () async {
              var galleryImage = await ImagePicker.pickImage(source: ImageSource.gallery);
            },
            icon: Icon(Icons.photo_library),
          ),
          IconButton(
            onPressed: () async {
              var image = await ImagePicker.pickVideo(source: ImageSource.camera);
            },
            icon: Icon(Icons.videocam),
          ),
          IconButton(
            onPressed: () async {
              var image = await ImagePicker.pickVideo(source: ImageSource.gallery);
            },
            icon: Icon(Icons.video_library),
          ),
        ],
      ),
    );
  }
}
