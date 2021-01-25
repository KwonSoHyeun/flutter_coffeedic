import 'package:flutter/material.dart';
import 'package:coffeedic/widgets/icon_badge.dart';

class AuthPage extends StatelessWidget {
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
            "로그인 \n하실래요?",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("로그인"),
        )
      ]),
    );
  }
}
