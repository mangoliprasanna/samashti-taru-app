import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/models/event_model.dart';
import 'package:samashti_app/widgets/event/event_card.dart';

class PulseWidget extends StatelessWidget {
  PulseWidget({Key key}) : super(key: key);

  var apiConfig = {
    "name": "eventByCategory",
    "param": {
      "category_id": 13,
      "user_id": NetworkHelper.getInstance().getUser().id
    }
  };

  void _launchURL(BuildContext context) async {
    try {
      await launch(
        'http://demo.samashti.co.in/registrations/',
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).accentColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.grey[400],
            child: Text(
                "“In a society that worships love, freedom, and beauty, dance is sacred. It is a prayer for the future, a remembrance of the past and a joyful exclamation for the present.” Pulse the national level dance fest of Jain deemed to be university is a gala of culture, heritage and diversity we possess.Dancing is a way to express what we feel and we believe there are no barriers to it. Keeping that in mind, Pulse is a dance fest where participants from various age groups can showcase their talents. From the year 2011 various personalities like Rakshith Shetty, Aishani Shetty, Master Anand, Paul Marshal, International dancer Sylvia Lo have been a part of pulse. The Charisma of pulse are the celebrities who come to judge and encourage the participants. From Sanam Johar and Poppin Ticko to Dharmesh, they all have judged various events of Pulse. Pulse provides a tremendous platform to the participants, where they're given an opportunity to put their best foot forward and to emerge as the winner."),
          ),
          Container(
            color: Colors.grey[400],
            padding: EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              padding: EdgeInsets.all(12.0),
              color: Theme.of(context).accentColor,
              onPressed: () {
                _launchURL(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                "Register Now",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Events",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          FutureBuilder(
            future: NetworkHelper.getInstance()
                .performPostRequest(apiConfig, "/event/", isSecure: true),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                var serverResponse = jsonDecode(snapshot.data);
                List<Widget> allEvents = new List();
                (serverResponse["response"]["result"] as List).forEach((f) {
                  allEvents.add(EventCard(EventModel.fromJson(f)));
                });
                return Column(
                  children: allEvents,
                );
              }
              return Text("asdasd");
            },
          )
        ],
      ),
    );
  }
}
