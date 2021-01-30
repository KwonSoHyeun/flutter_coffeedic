import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeedic/models/coffee.dart';
import 'package:flutter/services.dart';

CoffeebasePageState pageState;

class CoffeebasePage extends StatefulWidget {
  final String coffeeId;
  const CoffeebasePage(this.coffeeId);

  @override
  CoffeebasePageState createState() {
    // loadUpdateData(coffeeId);
    pageState = CoffeebasePageState();
    return pageState;
  }
}

class CoffeebasePageState extends State<CoffeebasePage> {
  Coffee coffee = new Coffee();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  int _selectedLevel_body = 3;
  int _selectedLevel_acidity = 3;
  int _selectedLevel_bitterness = 3;
  int _selectedLevel_balance = 3;

  List<DropdownMenuItem<int>> levelList = [];

  @override
  Widget build(BuildContext context) {
    loadLevelList();
    loadUpdateData(widget.coffeeId);

    return Scaffold(
        appBar: AppBar(
          title: Text("Add new coffee..."),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: new Column(children: <Widget>[
                nameField(),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                countryField(),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                cityField(),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                bodyField(),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                acidityField(),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                bitternessField(),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                balanceField(),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                descField(),
                Container(margin: EdgeInsets.only(bottom: 10.0)),
                imageField(),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // 텍스트폼필드의 상태가 적함하는
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          createDoc();
                          Navigator.pop(context);
                        }
                      },
                      // 버튼에 텍스트 부여
                      child: Text('Submit'),
                    )),
              ])),
            )));
  }

//FilteringTextInputFormatter.allow
//커피명
  Widget nameField() {
    return TextFormField(
      //obscureText: true,

      autocorrect: false,
      decoration: InputDecoration(labelText: "name", hintText: '커피명을 입력해주세요'),
      validator: (name) {
        if (name.isEmpty) {
          return '커피명을 입력하세요.';
        }
        return null;
      },
      initialValue: "coffee.name",
      onSaved: (name) => coffee.setName = name,
    );
  }

  //Country
  Widget countryField() {
    return TextFormField(
      //obscureText: true,
      decoration:
          InputDecoration(labelText: "country", hintText: '나라명을 입력해주세요'),
      validator: (country) {
        if (country.isEmpty) {
          return '나라명을 입력해주세요.';
        }
        return null;
      },
      initialValue: coffee.country,
      onSaved: (country) => coffee.setCountry = country,
    );
  }

  //City
  Widget cityField() {
    return TextFormField(
      //obscureText: true,
      decoration: InputDecoration(labelText: "city", hintText: '도시명을 입력해주세요'),
      validator: (city) {
        if (city.isEmpty) {
          return '도시명을 입력하세요.';
        }
        return null;
      },
      onSaved: (city) => coffee.setCity = city,
    );
  }

//body
  Widget bodyField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: "body", hintText: 'body'),
      value: _selectedLevel_body,
      items: levelList,
      onChanged: (value) {
        setState(() {
          _selectedLevel_body = value;
        });
      },
      onSaved: (body) => coffee.setBody = body,
    );
  }

//acidity
  Widget acidityField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: "acidity", hintText: 'acidity'),
      value: _selectedLevel_acidity,
      items: levelList,
      onChanged: (value) {
        setState(() {
          _selectedLevel_acidity = value;
        });
      },
      onSaved: (acidity) => coffee.setAcitidy = acidity,
    );
  }

  //acidity
  Widget bitternessField() {
    return DropdownButtonFormField(
      decoration:
          InputDecoration(labelText: "bitterness", hintText: 'bitterness'),
      value: _selectedLevel_bitterness,
      items: levelList,
      onChanged: (value) {
        setState(() {
          _selectedLevel_bitterness = value;
        });
      },
      onSaved: (bitterness) => coffee.setBitterness = bitterness,
    );
  }

  //balance
  Widget balanceField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: "balance", hintText: 'balance'),
      value: _selectedLevel_balance,
      items: levelList,
      onChanged: (value) {
        setState(() {
          _selectedLevel_balance = value;
        });
      },
      onSaved: (balance) => coffee.setBalance = balance,
    );
  }

  //Desc
  Widget descField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 3,
      maxLines: 10,
      decoration:
          InputDecoration(labelText: "description", hintText: '설명을 입력해주세요'),
      validator: (country) {
        if (country.isEmpty) {
          return '설명을 입력해주세요.';
        }
        return null;
      },
      onSaved: (country) => coffee.setDesc = country,
    );
  }

  Widget imageField() {
    return TextFormField(
      //obscureText: true,
      decoration:
          InputDecoration(labelText: "image", hintText: '이미지 경로를 입력해주세요'),
      onSaved: (image) => coffee.setImage = image,
    );
  }

  // 문서 생성 (Create)
  void createDoc() {
    FirebaseFirestore.instance.collection(coffee.colName).add(coffee.toMap());
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

  void loadLevelList() {
    levelList = [];
    levelList.add(new DropdownMenuItem(
      child: new Text('1'),
      value: 1,
    ));
    levelList.add(new DropdownMenuItem(
      child: new Text('2'),
      value: 2,
    ));
    levelList.add(new DropdownMenuItem(
      child: new Text('3'),
      value: 3,
    ));
    levelList.add(new DropdownMenuItem(
      child: new Text('4'),
      value: 4,
    ));
    levelList.add(new DropdownMenuItem(
      child: new Text('5'),
      value: 5,
    ));
  }

  void loadUpdateData(String coffeeId) {
    print("coffeeId:##################" + coffeeId.toString());
    if (coffeeId.isNotEmpty) {
      FirebaseFirestore.instance
          .collection(coffee.colName)
          .doc(coffeeId)
          .get()
          .then((doc) {
        coffee.setFromFirestore(doc.data());
        print("Cffee##########" + coffee.name.toString());
        //showReadDocSnackBar(doc);
      });
    }
  }
}
