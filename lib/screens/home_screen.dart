import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samashti_app/helpers/notification_handler.dart';
import 'package:samashti_app/helpers/theme_provider.dart';
import 'package:samashti_app/widgets/home/appbar.dart';
import 'package:samashti_app/widgets/home/home.dart';
import 'package:samashti_app/widgets/post/post_new.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static ThemeProvider theme;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    NotificationHandler.currentFcmInstance().configure(
      onLaunch: (Map<String, dynamic> notificationData){
        print("onLaunch");
        print(notificationData);
      },
      onMessage: (Map<String, dynamic> notificationData){
        print("onMessage");
        print(notificationData);
      },
      onResume: (Map<String, dynamic> notificationData){
        print("onResume");
        print(notificationData);
      }
    );
  }

  List<String> a = ["Profile", "Logout"];

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeProvider>(context);

    List<AppBar> appBarList = [
      AppBar(
        elevation: 0,
        title: Text("Home"),
        actions: <Widget>[CommonAppBarItems()],
      ),
      AppBar(
        title: Text("Events"),
        actions: <Widget>[CommonAppBarItems()],
      ),
      AppBar(
        title: Text("Pulse"),
        actions: <Widget>[CommonAppBarItems()],
      ),
      AppBar(
        title: Text("Results"),
        actions: <Widget>[CommonAppBarItems()],
      ),
    ];

    final List<Widget> widgetList = <Widget>[
      HomwWidget(),
      Text(
        'Index 1: Business',
      ),
      Text(
        'Index 2: School',
      ),
      Text(
        'Index 2: School',
      ),
    ];

    final List<BottomNavigationBarItem> navigationItemList = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.event),
        title: Text('Events'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.directions_walk),
        title: Text('Pulse'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.content_paste),
        title: Text('Results'),
      ),
    ];

    return Scaffold(
      appBar: appBarList.elementAt(_selectedIndex),
      body: SingleChildScrollView(
        child: widgetList.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => PostNew(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
