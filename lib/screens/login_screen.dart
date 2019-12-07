import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/helpers/user_provider.dart';
import 'package:samashti_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _globalKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailTxtController = new TextEditingController();
  TextEditingController _passwordTxtController = new TextEditingController();

  String _emailErrorMsg;
  String _passwordErrorMsg;

  bool canLoginClick = true;

  InputDecoration _getDecoration(String lblText, IconData prefixIcon,
      {String errorText}) {
    return InputDecoration(
      prefixIcon: Icon(
        prefixIcon,
        color: Colors.grey,
      ),
      errorText: errorText,
      labelStyle: TextStyle(color: Colors.grey),
      labelText: lblText,
    );
  }

  validateEmailInput(String s) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(s);
    if (!emailValid)
      _emailErrorMsg = "Enter Valid Email Address";
    else
      _emailErrorMsg = null;

    setState(() {});
  }

  validatePasswordInput(String s) {
    if (s.isEmpty)
      _passwordErrorMsg = "Password can not be empty.";
    else
      _passwordErrorMsg = null;

    setState(() {});
  }

  performLogin() async {
    var loginResponse = await NetworkHelper.getInstance().validateUser({
      "user_email": _emailTxtController.text,
      "user_password": _passwordTxtController.text
    });
    if (loginResponse is String) {
      showSnackbar(loginResponse);
    }
    if (loginResponse is UserModel) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("Auth", loginResponse.userToken);
      await Provider.of<UserProvider>(context).setUser(loginResponse);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed("/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailEditText = TextFormField(
      controller: _emailTxtController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: validateEmailInput,
      autocorrect: false,
      decoration: _getDecoration("Email Address", Icons.email,
          errorText: _emailErrorMsg),
    );
    final passwordEditText = TextFormField(
      controller: _passwordTxtController,
      onChanged: validatePasswordInput,
      autofocus: false,
      obscureText: true,
      autocorrect: false,
      decoration:
          _getDecoration("Password", Icons.lock, errorText: _passwordErrorMsg),
    );

    return Scaffold(
      key: _globalKey,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(32.0),
                child: Image.asset("assets/images/login_bg.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Login to account",
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
                child: emailEditText,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: passwordEditText,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width - 50,
                child: RaisedButton(
                  padding: EdgeInsets.all(12.0),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    if (canLoginClick) {
                      setState(() {
                        canLoginClick = false;
                      });
                      var email = _emailTxtController.text;
                      var password = _passwordTxtController.text;

                      if (email.isNotEmpty &&
                          password.isNotEmpty &&
                          _emailErrorMsg == null &&
                          _passwordErrorMsg == null) {
                        performLogin();
                      } else {
                        showSnackbar("Enter requried fields correctly.");
                        setState(() {});
                      }
                    }
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
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/resetpassword");
                },
                child: Text("Lost Password?"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSnackbar(String message) {
    canLoginClick = true;
    final snackBar = SnackBar(content: Text(message));
    _globalKey.currentState.showSnackBar(snackBar);
  }
}
