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
    //SearchBar search = SearchBar();
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
              "어떤 커피를 \n좋아하세요?",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: SearchBar(coffeelist: products, setkeyword: setSearchWord),
          ),
          buildHorizontalList(
              firestoreService.keywordFilter(coffeeproduct, _search_word)),
          buildVerticalList(
              firestoreService.keywordFilter(coffeeproduct, _search_word)),
        ],
      ),
    );
  }

  void setSearchWord(String word) {
    this._search_word = word;
    print("this._search_word######" + this._search_word);
    setState(() {});
  }

  filtedCoffeeList(List<Coffee> products) {
    List<Coffee> coffeeproduct = new List<Coffee>();
    coffeeproduct.addAll(products);
    return coffeeproduct;
  }

  buildHorizontalList(List<Coffee> products) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      child: (products != null)
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              primary: false,
              itemCount: products == null ? 0.0 : products.length,
              itemBuilder: (BuildContext context, int index) {
                if (index <= 4) {
                  Map place = products[index].toMap();
                  return HorizontalPlaceItem(coffeedata: place);
                } else
                  return Visibility(
                    child: Text("Gone"),
                    visible: false,
                  );
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
