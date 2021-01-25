import 'package:flutter/material.dart';
import 'package:coffeedic/widgets/icon_badge.dart';

class ExperiencePage extends StatelessWidget {
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
            "맛있는 커피점을 \n소개합니다.",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("경험치, 상점, 등등 공유"),
        )
      ]),
    );
  }
}
