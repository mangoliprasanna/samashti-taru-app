import 'package:flutter/material.dart';
import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/widgets/post/post_media.dart';
import 'package:video_player/video_player.dart';

class MediaVideoPlayer extends StatefulWidget {
  String videoUrl;

  MediaVideoPlayer({this.videoUrl, Key key}) : super(key: key);

  @override
  _MediaVideoPlayerState createState() => _MediaVideoPlayerState();
}

class _MediaVideoPlayerState extends State<MediaVideoPlayer> {
  VideoPlayerController _videoPlayerController;

  double videoAsspectRatio;

  bool isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    String mediaPath = NetworkHelper.getInstance().serverPath + widget.videoUrl;
    _videoPlayerController = VideoPlayerController.network(mediaPath);
    _videoPlayerController = _videoPlayerController
      ..initialize().then((_) {
        setState(() {});
      });
    _videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _videoPlayerController?.setLooping(false);
    super.dispose();
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
        AspectRatio(
          aspectRatio: 4 / 3,
          child: _videoPlayerController.value.initialized
              ? VideoPlayer(_videoPlayerController)
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
        IconButton(
          onPressed: _playPauseVideo,
          icon: Icon(
            _videoPlayerController.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _loadVideoWidget(),
    );
  }
}

class MediaController extends StatelessWidget {
  VideoPlayerController _videoPlayerController;

  String mediaType;

  String mediaUrl;

  MediaController({this.mediaUrl, this.mediaType, Key key}) : super(key: key);

  _loadPictureWidget() {
    return Image.network(
        NetworkHelper.getInstance().serverPath + "/" + mediaUrl);
  }

  @override
  Widget build(BuildContext context) {
    return getMediaType() == MediaType.picture
        ? _loadPictureWidget()
        : MediaVideoPlayer(
            videoUrl: mediaUrl,
          );
  }

  MediaType getMediaType() {
    return this.mediaType.contains("video")
        ? MediaType.video
        : MediaType.picture;
  }
}

/*
class PostItem extends StatefulWidget {
  PostModel postData;

  PostItem({this.postData, Key key}) : super(key: key);

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
        (widget.postData.postMedia != null)
            ? Container(
                padding: EdgeInsets.only(top: 8),
                width: MediaQuery.of(context).size.width,
                child: MediaController(
                  mediaType: widget.postData.postType,
                  mediaUrl: widget.postData.postMedia,
                ),
              )
            : SizedBox(),
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
                icon: Icon(Icons.thumb_up, color: Theme.of(context).accentColor,),
              ),
              Text(widget.postData.postLikes.toString())
            ],
          ),
        ),
      ],
    );
  }
}
*/