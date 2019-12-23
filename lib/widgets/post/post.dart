import 'package:flutter/material.dart';
import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/widgets/post/post_media.dart';
import 'package:video_player/video_player.dart';

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