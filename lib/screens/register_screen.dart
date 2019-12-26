import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:samashti_app/helpers/network_helper.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isBtnVisible = true;

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _mobileController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  InputDecoration _getDecoration(String lblText, IconData prefixIcon) {
    return InputDecoration(
      prefixIcon: Icon(
        prefixIcon,
        color: Colors.grey,
      ),
      labelStyle: TextStyle(color: Colors.grey),
      labelText: lblText,
    );
  }

  @override
  Widget build(BuildContext context) {
    final emailEditText = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      autofocus: false,
      decoration: _getDecoration("Email Address", Icons.email),
    );
    final passwordEditText = TextFormField(
      controller: _passwordController,
      autofocus: false,
      obscureText: true,
      autocorrect: false,
      decoration: _getDecoration("Password", Icons.lock),
    );
    final nameEditText = TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: _getDecoration("Full Name", Icons.account_circle),
    );
    final mobileEditText = TextFormField(
      keyboardType: TextInputType.phone,
      controller: _mobileController,
      autofocus: false,
      decoration: _getDecoration("Mobile Number", Icons.phone),
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Create new account"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Image.asset(
                    "assets/reg_bg.png",
                    height: 150,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Create a new account",
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                  "Get access to new events, notification and much more..",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: nameEditText,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: mobileEditText,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: emailEditText,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: passwordEditText,
              ),
              (isBtnVisible)
                  ? _buildSubmitButton(context)
                  : LinearProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }

  void showSnakBar(String text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  _performRegister() async {
    if (_nameController.text.isNotEmpty &&
        _mobileController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      var apiConfig = {
        "name": "createNewUser",
        "param": {
          "user_name": _nameController.text,
          "user_email": _emailController.text,
          "user_contact": _mobileController.text,
          "user_password": _passwordController.text
        }
      };
      setState(() {
        isBtnVisible = false;
      });
      var response = await NetworkHelper.getInstance()
          .performPostRequest(apiConfig, "/users/");
      setState(() {
        isBtnVisible = true;
      });
      var serverResponse = jsonDecode(response);
      if (serverResponse["response"]["result"] is String) {
        showSnakBar("Email already exists");
      } else {
        showSnakBar("Your account is created successfully.");
      }
    } else {
      showSnakBar("Require all fields.");
    }
  }

  Container _buildSubmitButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width - 50,
      child: OutlineButton(
        padding: EdgeInsets.all(16.0),
        textColor: Theme.of(context).accentColor,
        highlightedBorderColor: Theme.of(context).accentColor,
        onPressed: () {
          _performRegister();
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
    );
  }
}
