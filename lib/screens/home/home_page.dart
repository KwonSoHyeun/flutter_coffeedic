import 'package:coffeedic/language/translations.dart';
import 'package:flutter/material.dart';
import 'package:coffeedic/widgets/horizontal_place_item.dart';
import 'package:coffeedic/widgets/icon_badge.dart';
import 'package:coffeedic/widgets/search_bar.dart';
import 'package:coffeedic/models/coffee.dart';
import 'package:provider/provider.dart';
import 'package:coffeedic/services/firestore_service.dart';
import 'package:coffeedic/widgets/vertical_place_item.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:coffeedic/util/admanager.dart';

//import 'package:coffeedic/util/places.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _search_word = "";
  AdmobBannerSize bannerSize;

  @override
  Widget build(BuildContext context) {
    List<Widget> fakeBottomButtons = new List<Widget>();
    fakeBottomButtons.add(bannerContainer());

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 32,
          actions: <Widget>[
            IconButton(
              icon: IconBadge(
                icon: Icons.notifications_none,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: new ListView(
          children: <Widget>[
            new Container(
                height: MediaQuery.of(context).size.height -
                    (100 + AdmobBannerSize.BANNER.height),
                child: buildListView()),
            bannerContainer(),
          ],
        ));

    // new Container(
    //     height: MediaQuery.of(context).size.height - 150,
    //     child: buildListView()));

    // new Column(
    //   children: <Widget>[
    //     Expanded(child: buildListView()),
    //     bannerContainer(),
    //   ],
    // ));

    // new Padding(
    //   padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
    //   child: buildListView(),
    // ),
    // persistentFooterButtons: fakeBottomButtons,
  }

  void setSearchWord(String word) {
    setState(() {
      this._search_word = word;
    });
  }

  filtedCoffeeList(List<Coffee> products) {
    List<Coffee> coffeeproduct = new List<Coffee>();
    if (products != null) coffeeproduct.addAll(products);
    return coffeeproduct;
  }

  Widget buildListView() {
    final product = Provider.of<List<Coffee>>(context);
    final firestoreService = FirestoreService();

    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            Translations.of(context).trans('home_title'),
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: SearchBar(setkeyword: setSearchWord),
        ),
        if (product != null)
          buildHorizontalList(
              firestoreService.keywordFilter(product, _search_word)),
        if (product != null)
          buildVerticalList(
              firestoreService.keywordFilter(product, _search_word)),
      ],
    );
  }

  Widget buildHorizontalList(List<Coffee> products) {
    List<Coffee> horizontallist = new List<Coffee>();

    if (products != null && products.length >= 4) {
      //print("######products have data:::" + products.length.toString());
      horizontallist = products.sublist(0, 4);
    } else {
      horizontallist.addAll(products);
    }

    return Container(
      //color: Colors.white,
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      child: (horizontallist != null && horizontallist.length != 0)
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              primary: false,
              itemCount: horizontallist == null ? 0.0 : horizontallist.length,
              itemBuilder: (BuildContext context, int index) {
                Map place = horizontallist[index].toMap();
                return HorizontalPlaceItem(coffeedata: place);
              },
            )
          : Text("no data..."),
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
                  if (index >= 4) {
                    Map place = products[index].toMap();
                    return VerticalPlaceItem(coffeedata: place);
                  } else {
                    return Visibility(
                      child: Text("Gone"),
                      visible: false,
                    );
                  }
                },
              )
            : Text("no data..."));
  }

////'ca-app-pub-3940256099942544/2934735716', // test adUnit Id
  ///List<Widget> fakeBottomButtons = new List<Widget>();

  Widget bannerContainer() {
    return Container(
        height: 50,
        child: AdmobBanner(
            adUnitId: AdManager.bannerAdUnitId,
            adSize: AdmobBannerSize.BANNER,
            listener: (AdmobAdEvent event, Map<String, dynamic> args) {
              print(event);
              print(args);
              //handleEvent();
            }));
  }
}
