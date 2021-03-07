import 'package:coffeedic/models/coffee.dart';
import 'package:coffeedic/provider/heartcheck_provider.dart';
import 'package:coffeedic/util/alertdialogs.dart';
import 'package:coffeedic/widgets/vertical_heart_item.dart';
import 'package:flutter/material.dart';
import 'package:coffeedic/util/admanager.dart';
import 'package:provider/provider.dart';

class HeartPage extends StatefulWidget {
  @override
  _HeartPageState createState() => _HeartPageState();
}

class _HeartPageState extends State<HeartPage> {
  AdManager adMob = AdManager();

  HeartCheckProvider checkedProduct;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<List<Coffee>>(context);
    checkedProduct = Provider.of<HeartCheckProvider>(context);

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.help_outline_rounded),
              onPressed: () {
                showAlertDialogHelp(context, "heart");
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
                    //"맘에 드는 원두 \n보관함입니다.",
                    //"나만의 원두 보관함",
                    //내가 좋아하는 \n원두 보관함",
                    "내가 고른 \n원두 보관함",
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                //SizedBox(width: 20.0),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child:
                      buildVerticalList(checkedProduct.getHeartList(product)),
                )
              ],
            ),
          ])),
          adMob.bannerContainer(),
        ]));
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
    //print("buildVerticalList 실행시 길이" + products.length.toString());
    return Padding(
        padding: EdgeInsets.only(left: 20.0), //EdgeInsets.all(20.0),
        child: (products != null)
            ? ListView.builder(
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products == null ? 0 : products.length,
                itemBuilder: (BuildContext context, int index) {
                  //print("index::::" + index.toString());
                  Map place = products[index].toMap();
                  return VerticalHeartItem(coffeedata: place);
                },
              )
            : Text("no data..."));
  }
}
