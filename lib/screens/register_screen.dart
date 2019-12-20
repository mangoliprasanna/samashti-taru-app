import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isBtnVisible = true;
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
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        autocorrect: false,
        autofocus: false,
        decoration: _getDecoration("Email Address", Icons.email));
    final passwordEditText = TextFormField(
        autofocus: false,
        obscureText: true,
        autocorrect: false,
        decoration: _getDecoration("Password", Icons.lock));
    final nameEditText = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: _getDecoration("Full Name", Icons.account_circle),
    );

    final mobileEditText = TextFormField(
      keyboardType: TextInputType.phone,
      autofocus: false,
      decoration: _getDecoration("Mobile Number", Icons.phone),
    );
    return Scaffold(
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
              AnimatedSwitcher(
                duration: Duration(seconds: 2),
                child: (isBtnVisible) ? _buildSubmitButton(context) : LinearProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
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
