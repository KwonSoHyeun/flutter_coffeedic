import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirestoreFirstDemoState pageState;

class FirestoreFirstDemo extends StatefulWidget {
  @override
  FirestoreFirstDemoState createState() {
    pageState = FirestoreFirstDemoState();
    return pageState;
  }
}

class FirestoreFirstDemoState extends State<FirestoreFirstDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // 컬렉션명
  final String colName = "coffeebasic";

  // 필드명
  final String fnAcidity = "acidity";
  final String fnBalance = "balance";
  final String fnBiterness = "bitterness";
  final String fnBody = "body";
  final String fnCity = "city";
  final String fnCountry = "country";
  final String fnDesc = "desc";

  TextEditingController _newAcidityCon = TextEditingController();
  TextEditingController _newBalanceCon = TextEditingController();
  TextEditingController _newBiternessCon = TextEditingController();
  TextEditingController _newBody = TextEditingController();
  TextEditingController _newCityCon = TextEditingController();
  TextEditingController _newCountryCon = TextEditingController();
  TextEditingController _newDescCon = TextEditingController();

  TextEditingController _undAcidityCon = TextEditingController();
  TextEditingController _undBalanceCon = TextEditingController();
  TextEditingController _undBiternessCon = TextEditingController();
  TextEditingController _undBody = TextEditingController();
  TextEditingController _undCityCon = TextEditingController();
  TextEditingController _undCountryCon = TextEditingController();
  TextEditingController _undDescCon = TextEditingController();

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
              stream: Firestore.instance
                  .collection(colName)
                  .orderBy(fnCountry, descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text("Loading...");
                  default:
                    return ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return Card(
                          elevation: 2,
                          child: InkWell(
                            // Read Document
                            onTap: () {
                              showDocument(document.documentID);
                            },
                            // Update or Delete Document
                            onLongPress: () {
                              showUpdateOrDeleteDocDialog(document);
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
                                        document[fnCountry],
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        fnDesc.toString(),
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      document[fnCity],
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
          )
        ],
      ),
      // Create Document
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: showCreateDocDialog),
    );
  }

  /// Firestore CRUD Logic

  // 문서 생성 (Create)
  void createDoc(String acidity, String balance, String bitterness, String body,
      String city, String country, String desc) {
    print("acidity:" + acidity);
    Firestore.instance.collection(colName).add({
      fnAcidity: acidity,
      fnBalance: balance,
      fnBiterness: bitterness,
      fnBody: body,
      fnCity: city,
      fnCountry: country,
      fnDesc: desc,
    });
  }

  // 문서 조회 (Read)
  void showDocument(String documentID) {
    Firestore.instance
        .collection(colName)
        .document(documentID)
        .get()
        .then((doc) {
      showReadDocSnackBar(doc);
    });
  }

  // 문서 갱신 (Update)
  void updateDoc(
      String docID,
      String acidity,
      String balance,
      String bitterness,
      String body,
      String city,
      String country,
      String desc) {
    Firestore.instance.collection(colName).document(docID).updateData({
      fnAcidity: acidity,
      fnBalance: balance,
      fnBiterness: bitterness,
      fnBody: body,
      fnCity: city,
      fnCountry: country,
      fnDesc: desc,
    });
  }

  // 문서 삭제 (Delete)
  void deleteDoc(String docID) {
    Firestore.instance.collection(colName).document(docID).delete();
  }

  void showCreateDocDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create New Document"),
          content: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "City"),
                  controller: _newCityCon,
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "Country"),
                  controller: _newCountryCon,
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "Acidity"),
                  controller: _newAcidityCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Balance"),
                  controller: _newBalanceCon,
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "Bitterness"),
                  controller: _newBiternessCon,
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "Description"),
                  controller: _newDescCon,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                _newAcidityCon.clear();
                _newBalanceCon.clear();
                _newBiternessCon.clear();
                _newBody.clear();
                _newCityCon.clear();
                _newCountryCon.clear();
                _newDescCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Create"),
              onPressed: () {
                if (_newAcidityCon.text.isNotEmpty &&
                    _newBalanceCon.text.isNotEmpty &&
                    _newBiternessCon.text.isNotEmpty &&
                    _newBody.text.isNotEmpty &&
                    _newCityCon.text.isNotEmpty &&
                    _newCountryCon.text.isNotEmpty &&
                    _newDescCon.text.isNotEmpty) {
                  createDoc(
                      _newAcidityCon.text,
                      _newBalanceCon.text,
                      _newBiternessCon.text,
                      _newBody.text,
                      _newCityCon.text,
                      _newCountryCon.text,
                      _newDescCon.text);
                }
                _newAcidityCon.clear();
                _newBalanceCon.clear();
                _newBiternessCon.clear();
                _newBody.clear();
                _newCityCon.clear();
                _newCountryCon.clear();
                _newDescCon.clear();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void showReadDocSnackBar(DocumentSnapshot doc) {
    // _scaffoldKey.currentState
    //   ..hideCurrentSnackBar()
    //   ..showSnackBar(
    //     SnackBar(
    //       backgroundColor: Colors.deepOrangeAccent,
    //       duration: Duration(seconds: 5),
    //       content: Text("$fnName: ${doc[fnName]}\n$fnTel: ${doc[fnTel]}"
    //           "\n$fnDateTime: ${timestampToStrDateTime(doc[fnDateTime])}"),
    //       action: SnackBarAction(
    //         label: "Done",
    //         textColor: Colors.white,
    //         onPressed: () {},
    //       ),
    //     ),
    //   );
  }

  void showUpdateOrDeleteDocDialog(DocumentSnapshot doc) {
    _undAcidityCon.text = doc[fnAcidity];
    _undBalanceCon.text = doc[fnBalance];
    _undBiternessCon.text = doc[fnBiterness];
    _undBody.text = doc[fnBody];
    _undCityCon.text = doc[fnCity];
    _undCountryCon.text = doc[fnCountry];
    _undDescCon.text = doc[fnDesc];

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update/Delete Document"),
          content: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Acidity"),
                  controller: _undAcidityCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Balance"),
                  controller: _undBalanceCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Bitterness"),
                  controller: _undBiternessCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Body"),
                  controller: _undBody,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "City"),
                  controller: _undCityCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Country"),
                  controller: _undCountryCon,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Description"),
                  controller: _undDescCon,
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                _undAcidityCon.clear();
                _undBalanceCon.clear();
                _undBiternessCon.clear();
                _undBody.clear();
                _undCityCon.clear();
                _undCountryCon.clear();
                _undDescCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Update"),
              onPressed: () {
                if (_undAcidityCon.text.isNotEmpty &&
                    _undBalanceCon.text.isNotEmpty &&
                    _undBiternessCon.text.isNotEmpty &&
                    _undBody.text.isNotEmpty &&
                    _undCityCon.text.isNotEmpty &&
                    _undCountryCon.text.isNotEmpty &&
                    _undDescCon.text.isNotEmpty) {
                  updateDoc(
                      doc.documentID,
                      _undAcidityCon.text,
                      _undBalanceCon.text,
                      _undBiternessCon.text,
                      _undBody.text,
                      _undCityCon.text,
                      _undCountryCon.text,
                      _undDescCon.text);
                }
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Delete"),
              onPressed: () {
                deleteDoc(doc.documentID);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  String timestampToStrDateTime(Timestamp ts) {
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
        .toString();
  }
}
