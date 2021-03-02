import 'package:coffeedic/language/translations.dart';
import 'package:coffeedic/util/alertdialogs.dart';
import 'package:flutter/material.dart';
import 'package:coffeedic/widgets/horizontal_place_item.dart';
import 'package:coffeedic/widgets/search_bar.dart';
import 'package:coffeedic/models/coffee.dart';
import 'package:provider/provider.dart';
import 'package:coffeedic/services/firestore_service.dart';
import 'package:coffeedic/widgets/vertical_place_item.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:coffeedic/util/admanager.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AdManager adMob = AdManager();
  String _searchWord = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.help_outline_rounded),
              onPressed: () {
                showAlertDialogHelp(context, "home");
              },
              color: Colors.orange,
            ),
          ],
        ),
        body: new Column(
          children: <Widget>[
            Expanded(child: buildListView()),
          ],
        ));
  }

  void setSearchWord(String word) {
    setState(() {
      this._searchWord = word;
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
//resizeToAvoidBottomInset : false 키보드로 인한 재 계산을 하지 않도록
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20),
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

        //Banner 를 홈리스트뷰에서 보이지 않도록 한다. 자료를 효과적으로 이용 한 사람에게만 광고를 보여주자
        // Padding(
        //     padding: EdgeInsets.all(2.0),
        //     child: adMob.bannerContainer() //bannerContainer(),
        //     ),

        if (product != null)
          buildHorizontalList(
              firestoreService.keywordFilter(product, _searchWord)),
        if (product != null)
          buildVerticalList(
              firestoreService.keywordFilter(product, _searchWord)),
      ],
    );
  }

  Widget buildHorizontalList(List<Coffee> products) {
    List<Coffee> horizontallist = new List<Coffee>();

    if (products != null && products.length >= 4) {
      horizontallist = products.sublist(0, 4);
    } else {
      horizontallist.addAll(products);
    }

    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      height: 240.0,
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
                  if (index < 4) {
                    //if (index == 0) return bannerContainer();
                    return Visibility(
                      child: Text("Gone"),
                      visible: false,
                    );
                  } else {
                    // if (index == 6) return bannerContainer();
                    Map place = products[index].toMap();
                    return VerticalPlaceItem(coffeedata: place);
                  }
                },
              )
            : Text("no data..."));
  }

  Widget bannerContainer() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: InkWell(
            child: Container(
                // height: 50,
                child: AdmobBanner(
                    adUnitId: AdManager.bannerAdUnitId,
                    adSize: AdmobBannerSize.BANNER,
                    listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                      print(event);
                      print(args);
                      //handleEvent();
                    }))));
  }
}
