import 'package:flutter/material.dart';
import 'package:coffeedic/provider/firebase_auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CoffeebasePageState pageState;

class CoffeebasePage extends StatefulWidget {
  @override
  CoffeebasePageState createState() {
    pageState = CoffeebasePageState();
    return pageState;
  }
}

class CoffeebasePageState extends State<CoffeebasePage> {
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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseAuthProvider fp;

  @override
  void dispose() {
    _newAcidityCon.dispose();
    _newBalanceCon.dispose();
    _newBiternessCon.dispose();
    _newBody.dispose();
    _newCityCon.dispose();
    _newCountryCon.dispose();
    _newDescCon.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (fp == null) {
      fp = Provider.of<FirebaseAuthProvider>(context);
    }

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text("Coffee Base Data")),
        body: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                children: <Widget>[
                  //Header
                  Container(
                    height: 50,
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  // Input Area
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber, width: 1),
                    ),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _newAcidityCon,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.mail),
                            hintText: "Acidity",
                          ),
                        ),
                        TextField(
                          controller: _newBalanceCon,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.lock),
                            hintText: "Balance",
                          ),
                          obscureText: true,
                        ),
                        TextField(
                          controller: _newBiternessCon,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.lock),
                            hintText: "Bitterness",
                          ),
                          obscureText: true,
                        ),
                        TextField(
                          controller: _newBody,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.lock),
                            hintText: "Body",
                          ),
                          obscureText: true,
                        ),
                        TextField(
                          controller: _newCityCon,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.lock),
                            hintText: "City",
                          ),
                          obscureText: true,
                        ),
                        TextField(
                          controller: _newCountryCon,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.lock),
                            hintText: "Country",
                          ),
                          obscureText: true,
                        ),
                        TextField(
                          controller: _newDescCon,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.lock),
                            hintText: "Description",
                          ),
                          obscureText: true,
                        ),
                      ].map((c) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: c,
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),

            //  Creat Button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RaisedButton(
                color: Colors.indigo[300],
                child: Text(
                  "Create",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  FocusScope.of(context)
                      .requestFocus(new FocusNode()); // 키보드 감춤
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
                },
              ),
            ),
          ],
        ));
  }

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

  showLastFBMessage() {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red[400],
        duration: Duration(seconds: 10),
        content: Text(fp.getLastFBMessage()),
        action: SnackBarAction(
          label: "Done",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ));
  }

  showPasswordFBMessage() {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red[400],
        duration: Duration(seconds: 10),
        content: Text("비밀번호가 서로 다릅니다."),
        action: SnackBarAction(
          label: "OK",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ));
  }
}
