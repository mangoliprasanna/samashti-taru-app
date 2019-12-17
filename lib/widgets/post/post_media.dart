import 'dart:io';

import 'package:flutter/material.dart';
import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/models/media_model.dart';
import 'package:video_player/video_player.dart';

enum MediaType { picture, video }

class NewPostMedia extends StatefulWidget {
  File mediaPath;

  MediaType mediaType;

  MediaModel media;

  NewPostMedia({this.mediaPath, this.mediaType});

  @override
  _NewPostMediaState createState() => _NewPostMediaState();
}

class _NewPostMediaState extends State<NewPostMedia> {
  bool _isUploding = true;

  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    if (widget.mediaType == MediaType.video) {
      _videoPlayerController = VideoPlayerController.file(widget.mediaPath);
      _videoPlayerController.initialize().then((_) {
        setState(() {});
      });
    }
    _uploadMedia();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  _uploadMedia() async {
    var mediaserverResponse =
        await NetworkHelper.getInstance().uploadMedia(widget.mediaPath.path);
    print("Serer Response $mediaserverResponse");
    setState(() {
      _isUploding = false;
    });
    try{
      widget.media = MediaModel.fromJson(mediaserverResponse);
    } catch(e){
      print(e);
    }
  }

  _loadPictureWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Image.file(widget.mediaPath),
    );
  }

  _playPauseVideo() {
    setState(() {
      _videoPlayerController.value.isPlaying
          ? _videoPlayerController.pause()
          : _videoPlayerController.play();
    });
  }

  _loadVideoWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: _videoPlayerController.value.initialized
          ? Stack(
              children: <Widget>[
                _videoPlayerController.value.initialized
                    ? AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController),
                      )
                    : CircularProgressIndicator(),
                IconButton(
                    onPressed: _playPauseVideo,
                    icon: Icon(_videoPlayerController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow))
              ],
            )
          : CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.mediaType == MediaType.video
            ? _loadVideoWidget()
            : _loadPictureWidget(),
      ],
    );
  }
}
