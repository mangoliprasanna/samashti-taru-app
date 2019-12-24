import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/models/event_model.dart';
import 'package:samashti_app/widgets/event/event_card.dart';

class SankalpaWidget extends StatelessWidget {
  SankalpaWidget({Key key}) : super(key: key);

  var apiConfig = {
    "name": "eventByCategory",
    "param": {"category_id": 4, "user_id": 1}
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
            child: Center(
              child: Image.asset("assets/sankalpa.png"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.grey[400],
            child: Text(
                "Technology is like oxygen: ubiquitous, necessary and invincible.” Sankalpa, a national level Intercollegiate fest aims at bringing all the tech enthusiasts under one roof to give them a stem-winding experience. It witnesses techies from various domains like coding, gaming and others who battle it out with their skills to prove their rise as tech-savvy."),
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
            child: Text("Events", style: Theme.of(context).textTheme.title,),
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
