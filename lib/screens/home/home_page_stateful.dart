import 'package:flutter/material.dart';
import 'dart:async';
import 'package:coffeedic/util/places.dart';
import 'package:coffeedic/widgets/horizontal_place_item.dart';
import 'package:coffeedic/widgets/icon_badge.dart';
import 'package:coffeedic/widgets/search_bar.dart';
import 'package:coffeedic/widgets/vertical_place_item.dart';
import 'package:coffeedic/models/coffee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeedic/models/coffee.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamController<List<Coffee>> streamController = StreamController();
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
              "어떤 커피를 \n좋아하세요?",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: SearchBar(),
          ),
          buildHorizontalList2(context),
          buildVerticalList(),
        ],
      ),
    );
  }

  buildHorizontalList2(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('coffeebasic').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //print(snapshot.data.docs.length); //This value changes
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.hasData) {
            //print(snapshot.data.docs.length);
            return ListView.builder(
              primary: false,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                // return _personer(context, snapshot.data.documents[index], index);
                //return Text("data exist" + snapshot.data.docs[index]["name"]);
                Coffee coffeedata = new Coffee.setFromFirestore(
                    snapshot.data.docs[index].data());
                //Map place = Coffee.fromFirestore(snapshot.data.docs[index]);
                return HorizontalPlaceItem(coffeedata: coffeedata.toMap());
              },
            );
          } else {
            return Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }

  // buildHorizontalList(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.only(top: 10.0, left: 20.0),
  //     height: 250.0,
  //     width: MediaQuery.of(context).size.width,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       primary: false,
  //       itemCount: places == null ? 0.0 : places.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         Map place = places.reversed.toList()[index];
  //         return HorizontalPlaceItem(place: place);
  //       },
  //     ),
  //   );

  // return Flexible(
  //     child: StreamBuilder(
  //   stream: streamController.stream,
  //   builder: (BuildContext context, AsyncSnapshot snapshot) {
  //     if (!snapshot.hasData) {
  //       // 스냅샷에 데이터가 없으면 그냥 텍스트를 그린다.
  //       return Text("no data");
  //     } else {
  //       // 스냅샷에 데이터가 있으면, 즉 스트림에 데이터가 추가되면 리스트뷰를 그린다.
  //       return ListView.builder(
  //         itemCount: snapshot.data.length, // 스냅샷의 데이터 크기만큼 뷰 크기를 정한다.
  //         itemBuilder: (context, index) => _buildListTile(snapshot, index),
  //       );
  //     }
  //   },
  // ));
  //}

  buildVerticalList() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places[index];
          return VerticalPlaceItem(place: place);
        },
      ),
    );
  }
}
