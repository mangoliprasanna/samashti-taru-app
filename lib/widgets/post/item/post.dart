import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                "http://demo.samashti.co.in/profile/no-profile.png",
                height: 40.0,
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(left: 12.0, top: 4.0, bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Prasanna Mangoli",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      "Nav 30 at 10:18 AM",
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 8),
          width: MediaQuery.of(context).size.width,
          child: FadeInImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "https://via.placeholder.com/300",
            ),
            placeholder: AssetImage("assets/brand.png"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.thumb_up),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.comment),
              ),
            ],
          ),
        ),
        Container(
                  color: Colors.grey[300],
                  height: 20,
                ),
      ],
    );
  }
}
