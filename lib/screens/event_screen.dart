import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samashti_app/helpers/media_helper.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
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
      height: 300,
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
      appBar: AppBar(
        title: Text("Event Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildBackground(),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[500],
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.currentEvent.eventName,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(widget.currentEvent.categoryName)
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                size: 35.0,
              ),
              title: Text(widget.currentEvent.eventPerson),
              subtitle: Text(widget.currentEvent.eventContact),
              onTap: () async {
                String url = "tel:" + this.widget.currentEvent.eventContact;
                if (await UrlLauncher.canLaunch(url)) {
                  await UrlLauncher.launch(url);
                } else {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Unable to open app."),
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.timer,
                size: 35.0,
              ),
              title: Text(
                DateFormat("dd MMM, hh:mm a").format(
                  DateFormat("yyyy-MM-dd HH:mm:ss")
                      .parse(widget.currentEvent.eventStart),
                ),
              ),
              subtitle: Text("Event Date"),
            ),
                  Padding(
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
            FutureBuilder(
              future: NetworkHelper.getInstance()
                  .performPostRequest(_apiConfig, "/event/", isSecure: true),
              builder: (_, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapShot.connectionState == ConnectionState.done) {
                  List<Widget> eventGallery = new List();
                  var serverResponse = jsonDecode(snapShot.data)["response"];
                  if (serverResponse != null) {
                    serverResponse = serverResponse["result"];
                    if (serverResponse["event_album"] != null) {
                      serverResponse["event_album"].forEach((f) {
                        var media = GalleryModel.fromJson(f);
                        eventGallery.add(Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, bottom: 8.0, top: 8.0),
                          child: MediaController(
                            mediaUrl: media.galleryPath,
                            mediaType: media.galleryFormat,
                          ),
                        ));
                      });
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Photos & Videos",
                          style: Theme.of(context).textTheme.title,
                        ),
                        Container(
                          height: 150,
                          child: (eventGallery.length > 0)
                              ? ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: eventGallery,
                                )
                              : Center(
                                  child: Text(
                                      "Stay tuned for videos and photos of events"),
                                ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      // ext body: CustomScrollView(
      //   slivers: <Widget>[
      //     SliverAppBar(
      //       pinned: true,
      //       expandedHeight: 300.0,
      //       flexibleSpace: FlexibleSpaceBar(
      //           title: Text(
      //             widget.currentEvent.eventName,
      //             style: TextStyle(color: Colors.white),
      //             overflow: TextOverflow.fade,
      //           ),
      //           background: _buildBackground()),
      //     ),
      //     SliverList(
      //       delegate: SliverChildBuilderDelegate(
      //         (BuildContext context, int index) {
      //           return ListTile(
      //             onTap: () async {
      //               if (index == 2) {
      //                 String url =
      //                     "tel:" + this.widget.currentEvent.eventContact;
      //                 if (await UrlLauncher.canLaunch(url)) {
      //                   await UrlLauncher.launch(url);
      //                 } else {
      //                   Scaffold.of(context).showSnackBar(SnackBar(
      //                     content: Text("Unable to open app."),
      //                   ));
      //                 }
      //               }
      //             },
      //             leading: Icon(
      //               index == 1 ? Icons.phone : Icons.timer,
      //               size: 35.0,
      //             ),
      //             title: Text(index == 1
      //                 ? widget.currentEvent.eventPerson
      //                 : DateFormat("dd MMM, hh:mm a").format(
      //                     DateFormat("yyyy-MM-dd HH:mm:ss")
      //                         .parse(widget.currentEvent.eventStart))),
      //             subtitle: Text(index == 1
      //                 ? widget.currentEvent.eventContact
      //                 : "Event Date"),
      //           );
      //         },
      //         childCount: 2,
      //       ),
      //     ),
      //     SliverToBoxAdapter(
      //       child: 
      //     ),
      //     SliverToBoxAdapter(
      //       child:
      //     ),
      //   ],
      // ),
    );
  }
}
