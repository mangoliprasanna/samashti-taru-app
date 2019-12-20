import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(250.0),
                    bottomRight: Radius.circular(250.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 50.0,
                    ),
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 50.0,
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/brand.png",
                  height: 300,
                  width: 250,
                ),
              ),
              Container(
                padding: EdgeInsets.all(32.0),
                child: _getLoginOrCircular(),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getLoginOrCircular() {
    if (!_isLoading) {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width - 50,
            child: RaisedButton(
              padding: EdgeInsets.all(12.0),
              color: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width - 50,
            child: OutlineButton(
              padding: EdgeInsets.all(16.0),
              textColor: Theme.of(context).accentColor,
              highlightedBorderColor: Theme.of(context).accentColor,
              onPressed: () {
                print("Register");
                Navigator.pushNamed(context, "/register");
              },
              borderSide: BorderSide(
                color: Theme.of(context).accentColor,
                style: BorderStyle.solid,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                "Create an account",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: Text(
                "Click Here for Contingent Registration",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          )
        ],
      );
    } else {
      return Container(
        height: 70,
        width: 70,
        child: CircularProgressIndicator(),
      );
    }
  }
}
