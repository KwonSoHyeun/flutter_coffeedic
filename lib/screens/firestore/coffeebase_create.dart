import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeedic/models/coffee.dart';

CoffeebasePageState pageState;

class CoffeebasePage extends StatefulWidget {
  @override
  CoffeebasePageState createState() {
    pageState = CoffeebasePageState();
    return pageState;
  }
}

class CoffeebasePageState extends State<CoffeebasePage> {
  final coffee = new Coffee();

  TextEditingController _newName = TextEditingController();
  TextEditingController _newAcidityCon = TextEditingController();
  TextEditingController _newBalanceCon = TextEditingController();
  TextEditingController _newBiternessCon = TextEditingController();
  TextEditingController _newBody = TextEditingController();
  TextEditingController _newCityCon = TextEditingController();
  TextEditingController _newCountryCon = TextEditingController();
  TextEditingController _newDescCon = TextEditingController();
  TextEditingController _newImageCon = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _newName.dispose();
    _newAcidityCon.dispose();
    _newBalanceCon.dispose();
    _newBiternessCon.dispose();
    _newBody.dispose();
    _newCityCon.dispose();
    _newCountryCon.dispose();
    _newDescCon.dispose();
    _newImageCon.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        TextField(
                          controller: _newImageCon,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.lock),
                            hintText: "Image path",
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
                        _newDescCon.text,
                        _newImageCon.text);
                  }
                },
              ),
            ),
          ],
        ));
  }

  // 문서 생성 (Create)
  void createDoc(String acidity, String balance, String bitterness, String body,
      String city, String country, String desc, String image) {
    print("acidity:" + acidity);
    FirebaseFirestore.instance.collection(coffee.colName).add({
      coffee.fnAcidity: acidity,
      coffee.fnBalance: balance,
      coffee.fnBitterness: bitterness,
      coffee.fnBody: body,
      coffee.fnCity: city,
      coffee.fnCountry: country,
      coffee.fnDesc: desc,
      coffee.fnImage: image
    });
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
