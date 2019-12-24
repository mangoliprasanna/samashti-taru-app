import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/models/event_model.dart';
import 'package:samashti_app/widgets/event/event_card.dart';

class SamanwayaWidget extends StatelessWidget {
  SamanwayaWidget({Key key}) : super(key: key);

  var apiConfig = {
    "name": "eventByCategory",
    "param": {"category_id": 5, "user_id": 1}
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
              child: Image.asset("assets/samanvaya.png"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.grey[400],
            child: Text(
                "Samanvaya is an inter collegiate national level business fest organized annually by the students of Jain University. It receives enthusiasm from students and faculties of various reputed institutions and universities. Chronicling a span of sixteen successful years, it is known for its ardour providing a sincere representation of the echelons of commerce. Samanvaya instils the spirit of ambition where the greatest minds compete to emerge victorious in the struggle of firms."),
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
