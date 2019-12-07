import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samashti_app/helpers/theme_provider.dart';
import 'package:samashti_app/helpers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
    final theme = Provider.of<ThemeProvider>(context);
    final user = Provider.of<UserProvider>(context);
    final emailEditText = TextFormField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        autocorrect: false,
        initialValue: user.currentUser.userEmail,
        autofocus: false,
        enabled: false,
        decoration: _getDecoration("Email Address", Icons.email));
    final passwordEditText = TextFormField(
        autofocus: false,
        obscureText: true,
        autocorrect: false,
        decoration: _getDecoration("Password", Icons.lock));
    final nameEditText = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: user.currentUser.userName,
      decoration: _getDecoration("Full Name", Icons.account_circle),
    );

    final mobileEditText = TextFormField(
      keyboardType: TextInputType.phone,
      initialValue: user.currentUser.userContact,
      autofocus: false,
      decoration: _getDecoration("Mobile Number", Icons.phone),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
              Container(
                padding: EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width - 50,
                child: OutlineButton(
                  padding: EdgeInsets.all(16.0),
                  textColor: Theme.of(context).accentColor,
                  highlightedBorderColor: Theme.of(context).accentColor,
                  onPressed: () {
                    theme.setDarkTheme();
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
                    "Update",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
