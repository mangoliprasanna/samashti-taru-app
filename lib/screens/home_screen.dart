import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samashti_app/helpers/theme_provider.dart';
import 'package:samashti_app/widgets/home/appbar.dart';
import 'package:samashti_app/widgets/home/home.dart';
import 'package:samashti_app/widgets/post/new_post.dart';

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
        title: Text("Samyoga"),
        actions: <Widget>[CommonAppBarItems()],
      ),
      AppBar(
        title: Text("Sankalpa"),
        actions: <Widget>[CommonAppBarItems()],
      ),
      AppBar(
        title: Text("Samanvaya"),
        actions: <Widget>[CommonAppBarItems()],
      ),
      AppBar(
        title: Text("Pulse"),
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
        icon: Icon(Icons.business),
        title: Text('Samyoga'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.school),
        title: Text('Sankalpa'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.school),
        title: Text('Samanvaya'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.school),
        title: Text('Pulse'),
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
              builder: (_) => NewPost(),
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

  Padding _buildUserAvatar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: CircleAvatar(
          maxRadius: 20.0,
          backgroundImage: NetworkImage(
            "http://demo.samashti.co.in/profile/no-profile.png",
          ),
        ),
      ),
    );
  }
}
