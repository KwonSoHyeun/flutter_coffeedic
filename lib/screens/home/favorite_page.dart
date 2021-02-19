import 'package:flutter/material.dart';
import 'package:coffeedic/widgets/icon_badge.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  Map<String, int> favoritValue = {
    'aroma': 1,
    'body': 1,
    'sweet': 1,
    'acidity': 1,
    'bitter': 1,
    'balance': 1,
  };

  Map<String, bool> isSwitchOn = {
    'aroma': false,
    'body': false,
    'sweet': false,
    'acidity': false,
    'bitter': false,
    'balance': false,
  };

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
      body: ListView(
        children: <Widget>[
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
          ),
          buildListTile("aroma"),
          buildListTile("body"),
          buildListTile("sweet"),
          buildListTile("acidity"),
          buildListTile("bitter"),
          buildListTile("balance"),
          ListTile(title: saveButton())
        ],
      ),
    );
  }

  Widget buildListTile(String label) {
    return ListTile(
        //leading. 타일 앞에 표시되는 위젯. 참고로 타일 뒤에는 trailing 위젯으로 사용 가능
        leading: Switch(
          value: isSwitchOn[label],
          onChanged: (value) {
            setState(() {
              isSwitchOn[label] = value;
              print(label + "###" + value.toString());
            });
          },
          activeTrackColor: Colors.grey,
          activeColor: Colors.amberAccent,
        ),
        title: buildRangeIcon(label, favoritValue[label].toDouble()));
  }

  buildRangeIcon(String label, double initvalue) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
            flex: 5,
            child: RatingBar(
              initialRating: initvalue,
              isHalfAllowed: false,
              halfFilledIcon: Icons.star_half,
              filledIcon: isSwitchOn[label] ? Icons.star : Icons.star_border,
              filledColor: isSwitchOn[label] ? Colors.amber : Colors.grey,
              emptyIcon: Icons.star_border,
              size: 25,
              onRatingChanged: (double rating) {
                favoritValue[label] = rating.toInt();
                setState(() {
                  isSwitchOn[label] = true;
                });
              },
            )),
      ],
    );
  }

  Widget saveButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          onPressed: () {
            showAlertDialog(context);
          },
          child: Text('Save'),
          color: Colors.lightBlue,
          textColor: Colors.white,
        ));
  }

  getRememberInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitchOn['aroma'] = (prefs.getBool("on_aroma") ?? false);
      isSwitchOn['body'] = (prefs.getBool("on_body") ?? false);
      isSwitchOn['sweet'] = (prefs.getBool("on_sweet") ?? false);
      isSwitchOn['acidity'] = (prefs.getBool("on_acidity") ?? false);
      isSwitchOn['bitter'] = (prefs.getBool("on_bitter") ?? false);
      isSwitchOn['balance'] = (prefs.getBool("on_balance") ?? false);

      favoritValue['aroma'] = (prefs.getInt("favorite_aroma") ?? 1);
      favoritValue['body'] = (prefs.getInt("favorite_body") ?? 1);
      favoritValue['sweet'] = (prefs.getInt("favorite_sweet") ?? 1);
      favoritValue['acidity'] = (prefs.getInt("favorite_acidity") ?? 1);
      favoritValue['bitter'] = (prefs.getInt("favorite_bitter") ?? 1);
      favoritValue['balance'] = (prefs.getInt("favorite_balance") ?? 1);
    });
  }

  setRememberInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("on_aroma", isSwitchOn['aroma']);
    prefs.setBool("on_body", isSwitchOn['body']);
    prefs.setBool("on_sweet", isSwitchOn['sweet']);
    prefs.setBool("on_acidity", isSwitchOn['acidity']);
    prefs.setBool("on_bitter", isSwitchOn['bitter']);
    prefs.setBool("on_balance", isSwitchOn['balance']);

    prefs.setInt("favorite_aroma", favoritValue['aroma']);
    prefs.setInt("favorite_body", favoritValue['body']);
    prefs.setInt("favorite_sweet", favoritValue['sweet']);
    prefs.setInt("favorite_acidity", favoritValue['acidity']);
    prefs.setInt("favorite_bitter", favoritValue['bitter']);
    prefs.setInt("favorite_balance", favoritValue['balance']);
  }

  void showAlertDialog(BuildContext context) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('취향 저장'),
          content: Text("커피 취향이 저장되었습니다."),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
            // FlatButton(
            //   child: Text('Cancel'),
            //   onPressed: () {
            //     Navigator.pop(context, "Cancel");
            //   },
            // ),
          ],
        );
      },
    );
  }
}
