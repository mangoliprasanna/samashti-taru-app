import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samashti_app/helpers/user_provider.dart';
import 'package:samashti_app/models/post_model.dart';
import 'package:samashti_app/widgets/home/profilesection.dart';
import 'package:samashti_app/widgets/post/post.dart';
import 'package:samashti_app/widgets/post/post_provider.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  var post;

  @override
  Widget build(BuildContext context) {
    if (post == null) post = Provider.of<PostProvider>(context);
    return FutureBuilder(
      future: post.getAllPosts(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<PostModel> allPosts = new List();
          allPosts = snapshot.data;
          return ListView.builder(
            itemCount: allPosts.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) return WelcomeUser();
              return PostItem(postData: allPosts[index]);
            },
          );
        }
        if (snapshot.hasError) {
          return Text("Oops Something went wrong");
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class WelcomeUser extends StatelessWidget {
  const WelcomeUser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HomeProfileWidget(user: user),
        Container(
          color: Theme.of(context).accentColor,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.0),
                topRight: Radius.circular(35.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16, left: 32.0, bottom: 16.0),
                  child: Text(
                    "Latest Feed",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.title.color,
                        fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
