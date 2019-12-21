import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/models/event_model.dart';
import 'package:samashti_app/widgets/event/event_card.dart';
import 'package:url_launcher/url_launcher.dart';

class EventWidget extends StatelessWidget {
  var apiConfig = {
    "name": "loadAllEvents",
    "param": {"user_id": NetworkHelper.getInstance().getUser().id}
  };

  EventWidget({Key key}) : super(key: key);
  _buildGrid(String eventResponse) {
    var jsonResponse = jsonDecode(eventResponse);
    if (jsonResponse["response"] != null && 
        jsonResponse["response"]["result"] != null) {
      List<dynamic> eventList = jsonResponse["response"]["result"];
      List<EventModel> allEvents = new List();
      eventList.forEach((f) => allEvents.add(EventModel.fromJson(f)));
      return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: allEvents.length,
        itemBuilder: (context, index) {
          return EventCard(allEvents[index]);
        },
      );
    } 
    return Center(
      child: Container(
        child: Text("Oops! Something went wrong, please try again."),
      ),
    );
  }

  _launchURL(String contactNumber) async {
    contactNumber = 'tel: ' + contactNumber;
    if (await canLaunch(contactNumber)) {
      await launch(contactNumber);
    } else {
      throw 'Could not launch $contactNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: NetworkHelper.getInstance()
          .performPostRequest(apiConfig, "/event/", isSecure: true),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return _buildGrid(snapshot.data);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
