import 'package:flutter/material.dart';
import 'package:coffeedic/widgets/horizontal_place_item.dart';
import 'package:coffeedic/widgets/icon_badge.dart';
import 'package:coffeedic/widgets/search_bar.dart';
import 'package:coffeedic/widgets/vertical_place_item.dart';
import 'package:coffeedic/models/coffee.dart';
import 'package:provider/provider.dart';
import 'package:coffeedic/services/firestore_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _search_word = "";

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Coffee>>(context);
    List<Coffee> coffeeproduct = filtedCoffeeList(products);
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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "내게 맞는\n커피를 찾아보세요~",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: SearchBar(setkeyword: setSearchWord),
          ),
          if (coffeeproduct != null)
            buildHorizontalList(
                firestoreService.keywordFilter(coffeeproduct, _search_word)),
          if (coffeeproduct != null)
            buildVerticalList(
                firestoreService.keywordFilter(coffeeproduct, _search_word)),
        ],
      ),
    );
  }

  void setSearchWord(String word) {
    this._search_word = word;
    setState(() {});
  }

  filtedCoffeeList(List<Coffee> products) {
    List<Coffee> coffeeproduct = new List<Coffee>();
    if (products != null) coffeeproduct.addAll(products);
    return coffeeproduct;
  }

  buildHorizontalList(List<Coffee> products) {
    List<Coffee> horizontallist = new List<Coffee>();
    if (products != null && products.length >= 4) {
      horizontallist = products.sublist(0, 4);
    }

    return Container(
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
          : Text("Loading..."),
    );
  }

  buildVerticalList(List<Coffee> products) {
    return Padding(
        padding: EdgeInsets.all(20.0),
        child: (products != null)
            ? ListView.builder(
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products == null ? 0 : products.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index > 4) {
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
            : Text("Loading..."));
  }
}
