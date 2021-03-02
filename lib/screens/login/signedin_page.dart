import 'package:flutter/material.dart';
import 'package:coffeedic/provider/firebase_auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:coffeedic/screens/firestore/coffeebase_list.dart';

SignedInPageState pageState;

class SignedInPage extends StatefulWidget {
  @override
  SignedInPageState createState() {
    pageState = SignedInPageState();
    return pageState;
  }
}

class SignedInPageState extends State<SignedInPage> {
  FirebaseAuthProvider fp;
  TextStyle tsItem = const TextStyle(
      color: Colors.blueGrey, fontSize: 13, fontWeight: FontWeight.bold);
  TextStyle tsContent = const TextStyle(color: Colors.blueGrey, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseAuthProvider>(context);

    double propertyWith = 130;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              "로그인 되었습니다. \n환영합니다.",
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: propertyWith,
                        child: Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          fp.getUser().email,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
              ),
            ),
          ),
          // User's Info Area

          // Sign In Button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: RaisedButton(
              color: Colors.indigo[300],
              child: Text(
                "SIGN OUT",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                fp.signOut();
              },
            ),
          ),

          // Send Password Reset Email by English
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: RaisedButton(
              color: Colors.orange[300],
              child: Text(
                "Send Password Reset Email by English",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                fp.sendPasswordResetEmailByEnglish();
              },
            ),
          ),

          // Send Password Reset Email by Korean
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
            child: RaisedButton(
              color: Colors.orange[300],
              child: Text(
                "Send Password Reset Email by Korean",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                fp.sendPasswordResetEmailByKorean();
              },
            ),
          ),

          // Send Password Reset Email by Korean
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: RaisedButton(
              color: Colors.red[300],
              child: Text(
                "Withdrawal (Delete Account)",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                fp.withdrawalAccount();
              },
            ),
          ),

          managerPage()
        ],
      ),
    );
  }

  Widget managerPage() {
    if (fp.getUser().email == "tnflower@naver.com") {
      return // Firebase CloudStore CRUD
          Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: RaisedButton(
          color: Colors.blueGrey[300],
          child: Text(
            "관리자용 : 커피 데이타 입력/수정",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CoffeebaseList()));
          },
        ),
      );
    } else {
      return Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Text(""));
    }
  }
}
