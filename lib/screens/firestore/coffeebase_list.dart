import 'package:coffeedic/screens/firestore/coffeebase_create.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeedic/models/coffee.dart';

CoffeebaseListState pageState;

class CoffeebaseList extends StatefulWidget {
  @override
  CoffeebaseListState createState() {
    pageState = CoffeebaseListState();
    return pageState;
  }
}

class CoffeebaseListState extends State<CoffeebaseList> {
  Coffee coffee = new Coffee();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // 컬렉션명
  final String colName = "coffeebasic";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("FirestoreFirstDemo")),
      body: ListView(
        children: <Widget>[
          Container(
            height: 500,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(colName)
                  .orderBy(coffee.fnName, descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text("Loading...");
                  default:
                    return ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return Card(
                          elevation: 2,
                          child: InkWell(
                            // Read Document
                            onTap: () {
                              showUpdateOrDeleteDocument(document.id);
                            },
                            // Update or Delete Document
                            onLongPress: () {
                              // showUpdateOrDeleteDocDialog(document);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        document[coffee.fnName],
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        document[coffee.fnCity],
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      document[coffee.fnCountry],
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            ),
          ),
          // FlatButton(
          //   child: Text(
          //     "Create",
          //     style: TextStyle(color: Colors.blue, fontSize: 16),
          //   ),
          //   onPressed: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => CoffeebasePage()));
          //   },
          // )

          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CoffeebasePage(null, new Coffee.initiate())));
                },
                // 버튼에 텍스트 부여
                child: Text('Create'),
              )),
        ],
      ),
      // Create Document
    );
  }

  /// Firestore CRUD Logic

  // Update
  void showUpdateOrDeleteDocument(String documentID) {
    FirebaseFirestore.instance
        .collection(colName)
        .doc(documentID)
        .get()
        .then((doc) {
      Coffee coffeedata = new Coffee();
      final Map<String, dynamic> map = doc.data();

      coffeedata.setFromFirestore(map);
      print("coffee_data:#####" +
          coffeedata.name.toString() +
          coffeedata.country.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CoffeebasePage(documentID, coffeedata)));
    });
  }
}
