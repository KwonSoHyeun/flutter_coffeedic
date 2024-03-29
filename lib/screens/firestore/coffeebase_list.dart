import 'package:coffeedic/screens/firestore/coffeebase_create.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeedic/models/coffee.dart';
import 'package:provider/provider.dart';

CoffeebaseListState pageState;

class CoffeebaseList extends StatefulWidget {
  @override
  CoffeebaseListState createState() {
    pageState = CoffeebaseListState();
    return pageState;
  }
}

class CoffeebaseListState extends State<CoffeebaseList> {
  //Coffee coffee = new Coffee();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<List<Coffee>>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("FirestoreFirstDemo")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CoffeebasePage(null, new Coffee.initiate())));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.centerRight,
              child: Text(
                "ItemCount: ${product.length} ",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(Coffee.colName)
                  .orderBy(Coffee.fnCountry, descending: false)
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
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        document[Coffee.fnName],
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        document[Coffee.fnCity],
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      document[Coffee.fnCountry],
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
        ],
      ),
      // Create Document
    );
  }

  // Update& Delete
  void showUpdateOrDeleteDocument(String documentID) {
    FirebaseFirestore.instance
        .collection(Coffee.colName)
        .doc(documentID)
        .get()
        .then((doc) {
      //final Map<String, dynamic> map = doc.data();

      var coffeedata = Coffee.setFromFirestore(doc.data());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CoffeebasePage(documentID, coffeedata)));
    });
  }
}
