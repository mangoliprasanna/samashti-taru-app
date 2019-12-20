import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  VideoPlayerController _controller;

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    _checkForUser();
    _controller = VideoPlayerController.asset('assets/welcome_loading.mp4')
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
    _controller.addListener(_listenVideoEvents);
  }

  _checkForUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int user_id = prefs.getInt("user_id");
    if (user_id != null) {
      var prepareData = {
        "name": "renewKey",
        "param": {"user_id": user_id}
      };
      var serverResponse = await NetworkHelper.getInstance()
          .performPostRequest(prepareData, "/users/");
      if (serverResponse != null) {
        var serverResponseJson = jsonDecode(serverResponse);
        if (serverResponseJson["response"] != null &&
            serverResponseJson["response"]["status"] == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          NetworkHelper.getInstance().setUser(
              UserModel.fromJson(serverResponseJson["response"]["result"]));
          prefs.setInt(
              "user_id", serverResponseJson["response"]["result"]["id"]);
          isLoggedIn = true;
        }
      }
    }
  }

  _listenVideoEvents() {
    if (_controller.value.position == _controller.value.duration && !isLoggedIn) {
      Navigator.pushReplacementNamed(context, "/spalsh");
    }
    if(_controller.value.position == _controller.value.duration && isLoggedIn){
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_listenVideoEvents);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: _controller.value.initialized
          ? AspectRatio(
              aspectRatio: 16,
              child: VideoPlayer(_controller),
            )
          : Container(),
    );
  }
}
