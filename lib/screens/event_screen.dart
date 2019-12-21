import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/models/event_model.dart';

class EventScreen extends StatefulWidget {
  EventModel currentEvent;
  EventScreen({@required this.currentEvent, Key key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
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
            expandedHeight: 250.0,
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
                  onTap: () {
                    
                  },
                  leading: Icon(index == 1 ? Icons.phone : Icons.timer, size: 35.0,),
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
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('List Item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
