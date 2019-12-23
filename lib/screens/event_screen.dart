import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samashti_app/helpers/media_helper.dart';

import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/models/event_model.dart';

class EventScreen extends StatefulWidget {
  EventModel currentEvent;
  EventScreen({@required this.currentEvent, Key key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  var _apiConfig;

  @override
  void initState() {
    super.initState();
    _apiConfig = {
      "name": "eventDetails",
      "param": {
        "event_id": int.parse(widget.currentEvent.id),
        "user_id": NetworkHelper.getInstance().getUser().id
      }
    };
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.currentEvent.eventPicture != null
              ? NetworkHelper.getInstance().serverPath +
                  widget.currentEvent.eventPicture
              : "https://via.placeholder.com/150"),
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.currentEvent.eventName,
                  style: TextStyle(color: Colors.white),
                ),
                background: _buildBackground()),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  onTap: () {},
                  leading: Icon(
                    index == 1 ? Icons.phone : Icons.timer,
                    size: 35.0,
                  ),
                  title: Text(index == 1
                      ? widget.currentEvent.eventPerson
                      : DateFormat("dd MMM, hh:mm a").format(
                          DateFormat("yyyy-MM-dd HH:mm:ss")
                              .parse(widget.currentEvent.eventStart))),
                  subtitle: Text(index == 1
                      ? widget.currentEvent.eventContact
                      : "Event Date"),
                );
              },
              childCount: 2,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(widget.currentEvent.eventDesc)
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder(
              future: NetworkHelper.getInstance()
                  .performPostRequest(_apiConfig, "/event/", isSecure: true),
              builder: (_, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapShot.connectionState == ConnectionState.done) {
                  List<GalleryModel> eventGallery = new List();
                  var serverResponse =
                      jsonDecode(snapShot.data)["response"]["result"];
                  if (serverResponse["event_album"] != null) {
                    serverResponse["event_album"].forEach(
                        (f) => eventGallery.add(GalleryModel.fromJson(f)));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Pictures & Videos",
                          style: Theme.of(context).textTheme.title,
                        ),
                        (eventGallery.length > 0)
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: eventGallery.length,
                                itemBuilder: (context, index) {
                                  return MediaController(
                                    mediaUrl: eventGallery[index].galleryPath,
                                    mediaType: eventGallery[index].galleryFormat,
                                  );
                                },
                              )
                            : Text("No album")
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}