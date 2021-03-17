import 'package:coffeedic/language/translations.dart';
////import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeedic/models/coffee.dart';
import 'package:coffeedic/util/alertdialogs.dart';
import 'package:flutter/material.dart';
//import 'package:coffeedic/widgets/icon_badge.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffeedic/widgets/vertical_favorite_item.dart';
import 'package:coffeedic/services/firestore_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:coffeedic/util/admanager.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  AdManager adMob = AdManager();
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
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<List<Coffee>>(context);
    final firestoreService = FirestoreService();

    List<Coffee> filteredlist = new List<Coffee>();
    filteredlist = firestoreService.favoriteValuesFilter(
        product, isSwitchOn, favoritValue);

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.help_outline_rounded),
              onPressed: () {
                showAlertDialogHelp(context, "help_favorite");
              },
              color: Colors.orange,
            ),
          ],
        ),
        body: Column(children: [
          Expanded(
              child: Stack(alignment: Alignment.topLeft, children: <Widget>[
            ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                    Translations.of(context).trans('favorite_title'),
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(children: <Widget>[
                  SizedBox(width: 20.0),
                  Expanded(
                    flex: 5,
                    child: FlatButton(
                        child: Text(
                            Translations.of(context).trans('button_setting')),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Translations.of(context).trans('button_list')),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(bottom: 2),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                                firestoreService.favoriteItemCount.toString()),
                            height: 27.0,
                            width: 27.0,
                          )
                        ],
                      ),
                      color: !isVisibleList ? Colors.grey : Colors.blueAccent,
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          isVisibleList = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20.0),
                ]),
                Stack(
                  children: [
                    Visibility(
                        visible: !isVisibleList,
                        child: buildRatioValueSetting()),
                    Visibility(
                        visible: isVisibleList,
                        child: buildVerticalList(filteredlist)),
                  ],
                )
              ],
            ),
          ])),
          adMob.bannerContainer(),
        ]));
  }

  Widget buildRatioValueSetting() {
    return Column(
      children: [
        buildListTile(Translations.of(context).trans('item_aroma'), "aroma"),
        buildListTile(Translations.of(context).trans('item_body'), "body"),
        buildListTile(Translations.of(context).trans('item_sweet'), "sweet"),
        buildListTile(
            Translations.of(context).trans('item_acidity'), "acidity"),
        buildListTile(
            Translations.of(context).trans('item_bitterness'), "bitter"),
        buildListTile(
            Translations.of(context).trans('item_balance'), "balance"),
      ],
    );
  }

  Widget buildListTile(String label, String index) {
    return ListTile(
        leading: Switch(
          value: isSwitchOn[index],
          onChanged: (value) {
            setState(() {
              setIsOnInfo(index, value);
              isSwitchOn[index] = value;
            });
          },
          activeTrackColor: Colors.grey,
          activeColor: Colors.amberAccent,
        ),
        title: buildRangeIcon(label, index, favoritValue[index].toDouble()));
  }

  buildRangeIcon(String label, String index, double initvalue) {
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
                  isSwitchOn[index] ? Icons.star : Icons.star,
                  color: isSwitchOn[index] ? Colors.amber : Colors.grey[600],
                );
              },
              onRatingUpdate: (rating) {
                setState(() {
                  if (!isSwitchOn[index]) {
                    isSwitchOn[index] = true;
                    setIsOnInfo(index, true);
                  }
                  favoritValue[index] = rating.toInt();
                  setFavoriteInfo(index, rating.toInt());
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
    await showDialog(
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

  Widget buildVerticalList(List<Coffee> products) {
    return Padding(
        padding: EdgeInsets.only(left: 20.0), //EdgeInsets.all(20.0),
        child: (products != null)
            ? ListView.builder(
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products == null ? 0 : products.length,
                itemBuilder: (BuildContext context, int index) {
                  Map place = products[index].toMap();
                  return VerticalPlaceItem(coffeedata: place);
                },
              )
            : Text("no data..."));
  }
}
