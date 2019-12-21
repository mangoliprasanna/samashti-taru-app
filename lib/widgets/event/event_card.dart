import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/models/event_model.dart';
import 'package:samashti_app/screens/event_screen.dart';

class EventCard extends StatelessWidget {
  final EventModel currentEvent;

  const EventCard(this.currentEvent);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => EventScreen(
              currentEvent: currentEvent,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(currentEvent.eventPicture != null
                ? NetworkHelper.getInstance().serverPath +
                    currentEvent.eventPicture
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  currentEvent.eventName,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    currentEvent.categoryName,
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ),
                Container(
                  height: 2.0,
                  color: Theme.of(context).accentColor,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    DateFormat("dd MMM, hh:mm a").format(
                        DateFormat("yyyy-MM-dd HH:mm:ss")
                            .parse(currentEvent.eventStart)),
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
