import 'package:flutter/material.dart';
import 'package:samashti_app/models/post_model.dart';
import 'package:samashti_app/widgets/post/post_media.dart';
import 'package:video_player/video_player.dart';

class PostVideoPlayer extends StatefulWidget {
  String videUrl;

  PostVideoPlayer({String videoUrl, Key key}) : super(key: key);

  @override
  _PostVideoPlayerState createState() => _PostVideoPlayerState();
}

class _PostVideoPlayerState extends State<PostVideoPlayer> {
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
  }

  _playPauseVideo() {
    setState(() {
      _videoPlayerController.value.isPlaying
          ? _videoPlayerController.pause()
          : _videoPlayerController.play();
    });
  }

  _loadVideoWidget() {
    return Stack(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _videoPlayerController.value.initialized
          ? _loadVideoWidget()
          : CircularProgressIndicator(),
    );
  }
}

class PostMedia extends StatelessWidget {
  VideoPlayerController _videoPlayerController;

  String mediaType;

  String mediaUrl;

  PostMedia({String mediaUrl, String mediaType, Key key}) : super(key: key);

  _loadPictureWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Image.network(mediaUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getMediaType() == MediaType.picture
        ? _loadPictureWidget()
        : PostVideoPlayer(
            videoUrl: mediaUrl,
          );
  }

  MediaType getMediaType() {
    return this.mediaType.contains("video")
        ? MediaType.video
        : MediaType.picture;
  }
}

class PostItem extends StatefulWidget {

  PostModel postData;

  PostItem({PostModel postData, Key key}) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {

  bool _descTextShowFlag = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                widget.postData.userProfile,
                height: 40.0,
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(left: 12.0, top: 4.0, bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.postData.userName,
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      widget.postData.postDate,
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 8),
          width: MediaQuery.of(context).size.width,
          child: PostMedia(mediaType: widget.postData.postType, mediaUrl: widget.postData.postMedia,),
        ),
        Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.postData.postDesc,
                maxLines: _descTextShowFlag ? 8 : 2,
                textAlign: TextAlign.start,
              ),
              (widget.postData.postDesc.length > 10)
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _descTextShowFlag = !_descTextShowFlag;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          _descTextShowFlag
                              ? Text(
                                  "Show Less",
                                  style: TextStyle(color: Colors.grey),
                                )
                              : Text("Show More",
                                  style: TextStyle(color: Colors.grey))
                        ],
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.thumb_up),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.comment),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
