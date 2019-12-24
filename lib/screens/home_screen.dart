import 'package:flutter/material.dart';
import 'package:samashti_app/helpers/notification_handler.dart';
import 'package:samashti_app/widgets/event/event.dart';
import 'package:samashti_app/widgets/event/pulse.dart';
import 'package:samashti_app/widgets/event/samanwaya.dart';
import 'package:samashti_app/widgets/event/samayoga.dart';
import 'package:samashti_app/widgets/event/sankalpa.dart';
import 'package:samashti_app/widgets/home/appbar.dart';
import 'package:samashti_app/widgets/home/home.dart';
import 'package:samashti_app/widgets/post/post_new.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    NotificationHandler.currentFcmInstance().configure(
        onLaunch: (Map<String, dynamic> notificationData) {
      print("onLaunch");
      print(notificationData);
    }, onMessage: (Map<String, dynamic> notificationData) {
      print("onMessage");
      print(notificationData);
    }, onResume: (Map<String, dynamic> notificationData) {
      print("onResume");
      print(notificationData);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<AppBar> appBarList = [
      AppBar(
        elevation: 0,
        title: Text("Home"),
        actions: <Widget>[CommonAppBarItems()],
      ),
      AppBar(
        title: Text("Tarusamskruti"),
        bottom: TabBar(
          tabs: [
            Tab(
              text: "Sankalpa",
            ),
            Tab(
              text: "Samayoga",
            ),
            Tab(
              text: "Samanwaya",
            ),
          ],
        ),
        actions: <Widget>[CommonAppBarItems()],
      ),
      AppBar(
        title: Text("Pulse"),
        actions: <Widget>[CommonAppBarItems()],
      )
    ];

    final List<Widget> widgetList = <Widget>[
      HomeWidget(),
      EventWidget(),
      PulseWidget()
    ];

    final List<BottomNavigationBarItem> navigationItemList = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: Image.asset("assets/taru.png", height: 32, width: 32,),
        title: Text("Tarusamskruti"),
      ),
      BottomNavigationBarItem(
        icon: Image.asset("assets/pulse.png", height: 32, width: 32,),
        title: Text('Pulse'),
      ),
    ];

    if (_selectedIndex == 1) {
      return DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          appBar: appBarList[_selectedIndex],
          bottomNavigationBar:
              _buildBottomNavigationBar(navigationItemList, context),
          body: TabBarView(
            children: [
              SankalpaWidget(),
              SamayogsWidget(),
              SamanwayaWidget(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
        appBar: appBarList.elementAt(_selectedIndex),
        body: widgetList.elementAt(_selectedIndex),
        bottomNavigationBar:
            _buildBottomNavigationBar(navigationItemList, context));
  }

  BottomNavigationBar _buildBottomNavigationBar(
      List<BottomNavigationBarItem> navigationItemList, BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      items: navigationItemList,
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).accentColor,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}
