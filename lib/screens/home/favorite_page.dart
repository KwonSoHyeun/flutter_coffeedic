import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:coffeedic/widgets/icon_badge.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffeedic/widgets/vertical_favorite_item.dart';
import 'package:coffeedic/models/coffee.dart';
import 'package:provider/provider.dart';
import 'package:coffeedic/services/firestore_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  bool isVisibleList = false;
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
  initState() {
    super.initState();
    getRememberInfo();
    print("initState ###");
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<List<Coffee>>(context);
    final firestoreService = FirestoreService();

    return Scaffold(
        appBar: AppBar(
          // toolbarHeight: 30,
          actions: <Widget>[
            IconButton(
              icon: IconBadge(
                icon: Icons.notifications_none,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(alignment: Alignment.topLeft, children: <Widget>[
          ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "원두 취향 \n찾아 보시겠어요?",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(children: <Widget>[
                SizedBox(width: 20.0),
                Expanded(
                  flex: 5,
                  child: FlatButton(
                      child: Text('취향 설정'),
                      color: isVisibleList ? Colors.grey : Colors.blueAccent,
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          isVisibleList = false;
                        });
                      }),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                    )),
                Expanded(
                  flex: 5,
                  child: FlatButton(
                    child: Text("원두 목록"),
                    color: !isVisibleList ? Colors.grey : Colors.blueAccent,
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        isVisibleList = true;
                        //print("isVisibleList #### $isVisibleList");
                      });
                    },
                  ),
                ),
                SizedBox(width: 20.0),
              ]),
              Stack(
                children: [
                  Visibility(
                      visible: !isVisibleList, child: buildRatioValueSetting()),
                  Visibility(
                      visible: isVisibleList,
                      child: buildVerticalList(firestoreService)),
                ],
              )
            ],
          ),
        ]));
  }

  Widget buildRatioValueSetting() {
    return Column(
      children: [
        buildListTile("aroma"),
        buildListTile("body"),
        buildListTile("sweet"),
        buildListTile("acidity"),
        buildListTile("bitter"),
        buildListTile("balance"),
      ],
    );
  }

  Widget buildListTile(String label) {
    return ListTile(
        leading: Switch(
          value: isSwitchOn[label],
          onChanged: (value) {
            setState(() {
              setIsOnInfo(label, value);
              isSwitchOn[label] = value;
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
            child: RatingBar.builder(
              initialRating: initvalue,
              minRating: 0,
              itemSize: 25.0,
              direction: Axis.horizontal,
              //allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) {
                return Icon(
                  isSwitchOn[label] ? Icons.star : Icons.star,
                  color: isSwitchOn[label] ? Colors.amber : Colors.grey[600],
                );
              },
              onRatingUpdate: (rating) {
                setState(() {
                  if (!isSwitchOn[label]) {
                    isSwitchOn[label] = true;
                    setIsOnInfo(label, true);
                  }
                  favoritValue[label] = rating.toInt();
                  setFavoriteInfo(label, rating.toInt());
                });
              },
            ))
      ],
    );
  }

  getRememberInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitchOn['aroma'] = (prefs.getBool("o_aroma") ?? false);
      isSwitchOn['body'] = (prefs.getBool("o_body") ?? false);
      isSwitchOn['sweet'] = (prefs.getBool("o_sweet") ?? false);
      isSwitchOn['acidity'] = (prefs.getBool("o_acidity") ?? false);
      isSwitchOn['bitter'] = (prefs.getBool("o_bitter") ?? false);
      isSwitchOn['balance'] = (prefs.getBool("o_balance") ?? false);

      favoritValue['aroma'] = (prefs.getInt("f_aroma") ?? 1);
      favoritValue['body'] = (prefs.getInt("f_body") ?? 1);
      favoritValue['sweet'] = (prefs.getInt("f_sweet") ?? 1);
      favoritValue['acidity'] = (prefs.getInt("f_acidity") ?? 1);
      favoritValue['bitter'] = (prefs.getInt("f_bitter") ?? 1);
      favoritValue['balance'] = (prefs.getInt("f_balance") ?? 1);
    });
  }

  setIsOnInfo(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("o_" + key, value);
  }

  setFavoriteInfo(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("f_" + key, value);
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

  Widget buildVerticalList(FirestoreService _firestoreService) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestoreService.getFavoritCoffees(isSwitchOn, favoritValue),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            if (!snapshot.hasData) {
              return Text("no data...");
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  return ListView.builder(
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        //print("length#####" + snapshot.data.docs.length.toString());
                        Map place = snapshot.data.docs[index].data();
                        return VerticalPlaceItem(place: place);
                      });
              }
            }
          },
        ));
  }
}
