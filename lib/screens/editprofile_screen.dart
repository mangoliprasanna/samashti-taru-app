import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:samashti_app/helpers/network_helper.dart';
import 'package:samashti_app/models/user_model.dart';

class EditProfileWidget extends StatefulWidget {
  UserModel currentUser;
  EditProfileWidget({@required this.currentUser, Key key}) : super(key: key);

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emaiController = new TextEditingController();
  TextEditingController _mobileController = new TextEditingController();

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
  void initState() {
    super.initState();
    _nameController.text = widget.currentUser.userName;
    _mobileController.text = widget.currentUser.userContact;
    _emaiController.text = widget.currentUser.userEmail;
  }
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final emailEditText = TextFormField(
      controller: _emaiController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      autofocus: false,
      enabled: false,
      decoration: _getDecoration(
        "Email Address",
        Icons.email,
      ),
    );
    final nameEditText = TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: _getDecoration("Full Name", Icons.account_circle),
    );

    final mobileEditText = TextFormField(
      controller: _mobileController,
      keyboardType: TextInputType.phone,
      autofocus: false,
      decoration: _getDecoration("Mobile Number", Icons.phone),
    );
    return Column(
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
            onPressed: () async {
              if (_mobileController.text.isNotEmpty &&
                  _nameController.text.isNotEmpty) {
                    setState(() {
                      _isLoading = true;
                    });
                var updateUser = {
                  "name": "updateUser",
                  "param": {
                    "id": "1",
                    "user_name": "Prasanna Mangoli",
                    "user_contact": "9404319393"
                  }
                };
                var res = await NetworkHelper.getInstance()
                    .performPostRequest(updateUser, "/users/", isSecure: true);
                var serverResponse = jsonDecode(res);
                if (serverResponse["response"] != null &&
                    serverResponse["response"]["status"] == 200) {
                      _isLoading = false;
                      widget.currentUser.userName = _nameController.text;
                      widget.currentUser.userContact = _mobileController.text;
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Profile Information updated."),
                    ),
                  );
                } else {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Unable to update profile, please try again."),
                    ),
                  );
                }
              } else {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("All fields are requried."),
                  ),
                );
              }
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
        ),
        (_isLoading)
        ? LinearProgressIndicator() : SizedBox()
      ],
    );
  }
}
