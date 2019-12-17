import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:samashti_app/helpers/user_provider.dart';
import 'package:samashti_app/widgets/post/post_media.dart';
import 'package:samashti_app/widgets/post/post_provider.dart';

class PostNew extends StatefulWidget {
  PostNew({Key key}) : super(key: key);

  @override
  _PostNewState createState() => _PostNewState();
}

class _PostNewState extends State<PostNew> {
  UserProvider user;

  NewPostMedia _postMedia;

  TextEditingController _postContentController = new TextEditingController();

  Map<String, dynamic> postData;

  PostProvider post;

  bool _isPosting = false;

  @override
  Widget build(BuildContext context) {
    post = Provider.of<PostProvider>(context);
    user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
        actions: <Widget>[
          FlatButton(
            child: (_isPosting)
                ? CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    strokeWidth: 2,
                  )
                : Text(
                    "Post",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
            onPressed: () async {
              setState(() {
                _isPosting = true;
              });
              postData = new Map();
              if (_postContentController.text.isNotEmpty) {
                postData["name"] = "newPost";
                postData["param"] = new Map<String, dynamic>();
                postData["param"]["post_media"] = _postMedia?.media?.toJson();
                postData["param"]["post_desc"] = _postContentController.text;
                String response = await post?.insertNewPost(postData);
                print("Post Response $response");
                if(response == null){
                  //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Oops, Something went wrong please try again."),));
                } else {
                  Navigator.pop(context);
                }
              }
            },
          )
        ],
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
              _buildPostContentInput(context)
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildMediaSelector(),
    );
  }

  Expanded _buildPostContentInput(BuildContext context) {
    return Expanded(
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
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: TextField(
                controller: _postContentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autocorrect: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  border: InputBorder.none,
                  hintText: 'What\'s happening? ',
                  hintStyle: TextStyle(fontSize: 20.0),
                ),
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            (_postMedia != null) ? _getPostMedia() : SizedBox(),
          ],
        ),
      ),
    );
  }

  ButtonBar _buildMediaSelector() {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          onPressed: () async {
            var cameraImage = await ImagePicker.pickImage(
                source: ImageSource.camera, imageQuality: 50);
            if (cameraImage != null) {
              setState(() {
                _postMedia = NewPostMedia(
                  mediaPath: cameraImage,
                  mediaType: MediaType.picture,
                );
              });
            }
          },
          icon: Icon(Icons.camera_alt),
        ),
        IconButton(
          onPressed: () async {
            var galleryImage = await ImagePicker.pickImage(
                source: ImageSource.gallery, imageQuality: 50);
            if (galleryImage != null) {
              setState(() {
                _postMedia = NewPostMedia(
                  mediaPath: galleryImage,
                  mediaType: MediaType.picture,
                );
              });
            }
          },
          icon: Icon(Icons.photo_library),
        ),
        IconButton(
          onPressed: () async {
            var recordedVideo =
                await ImagePicker.pickVideo(source: ImageSource.camera);
            if (recordedVideo != null) {
              setState(() {
                _postMedia = NewPostMedia(
                  mediaPath: recordedVideo,
                  mediaType: MediaType.video,
                );
              });
            }
          },
          icon: Icon(Icons.videocam),
        ),
      ],
    );
  }

  Stack _getPostMedia() {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        _postMedia,
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            height: 30,
            width: 30,
            color: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 15.0,
              ),
              onPressed: () {
                setState(() {
                  _postMedia = null;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
