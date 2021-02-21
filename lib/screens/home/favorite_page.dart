import 'package:flutter/material.dart';
import 'package:coffeedic/widgets/icon_badge.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffeedic/widgets/vertical_place_item_test.dart';
import 'package:coffeedic/util/places.dart';
import 'package:coffeedic/models/coffee.dart';
import 'package:provider/provider.dart';
import 'package:coffeedic/services/firestore_service.dart';

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
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "원두 취향 \n찾아 보시겠어요?",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                    )),
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
                        print("isVisibleList #### $isVisibleList");
                      });
                    },
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                    )),
              ]),
              Stack(
                children: [
                  AnimatedOpacity(
                      opacity: isVisibleList ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 500),
                      child: buildRatioValueSetting()),
                  AnimatedOpacity(
                      opacity: isVisibleList ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      child: buildVerticalListTest(product)),
                ],
                /*
                          if (product != null)
            buildVerticalList(
                firestoreService.keywordFilter(product, _search_word)),
                */
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

  // Widget buildListTileOpacity(String label) {
  //   return AnimatedOpacity(
  //       opacity: isVisibleList ? 0.0 : 1.0,
  //       duration: Duration(milliseconds: 500),
  //       child: buildListTile(label));
  // }

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
            child: RatingBar(
              initialRating: initvalue,
              isHalfAllowed: false,
              halfFilledIcon: Icons.star_half,
              filledIcon: isSwitchOn[label] ? Icons.star : Icons.star_border,
              filledColor: isSwitchOn[label] ? Colors.amber : Colors.grey,
              emptyIcon: Icons.star_border,
              size: 25,
              onRatingChanged: (double rating) {
                setState(() {
                  setFavoriteInfo(label, rating.toInt());
                  favoritValue[label] = rating.toInt();
                  isSwitchOn[label] = true;
                });
              },
            )),
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

  Widget buildVerticalListTest(List<Coffee> product) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: product == null ? 0 : product.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = product[index].toMap();
          return VerticalPlaceItem(place: place);
        },
      ),
    );
  }
}
