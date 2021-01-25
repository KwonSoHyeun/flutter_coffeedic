import 'package:flutter/material.dart';
import 'package:coffeedic/widgets/icon_badge.dart';

class FavouritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications_none,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "원두 취향 \n찾아 보시겠어요?",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("원두 취향 찾기"),
        )
      ]),
    );
  }
}
