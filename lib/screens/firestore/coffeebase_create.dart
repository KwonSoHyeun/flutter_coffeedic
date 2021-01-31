import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeedic/models/coffee.dart';
import 'package:flutter/services.dart';

CoffeebasePageState pageState;

class CoffeebasePage extends StatefulWidget {
  Coffee coffeeData;
  CoffeebasePage(this.coffeeData);

  //Coffee coffeeData;

  @override
  CoffeebasePageState createState() {
    //coffeeData = coffee_param;
    pageState = CoffeebasePageState();
    return pageState;
  }
}

class CoffeebasePageState extends State<CoffeebasePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<int>> levelList = [];

  @override
  Widget build(BuildContext context) {
    loadLevelList();

    return Scaffold(
        appBar: AppBar(
          title: Text("Add new widget.coffeeData..."),
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

//커피명
  Widget nameField() {
    return TextFormField(
      autocorrect: false,
      decoration: InputDecoration(labelText: "name", hintText: '커피명을 입력해주세요'),
      validator: (name) {
        if (name.isEmpty) {
          return '커피명을 입력하세요.';
        }
        return null;
      },
      initialValue: widget.coffeeData.name,
      onSaved: (name) => widget.coffeeData.setName = name,
    );
  }

  //Country
  Widget countryField() {
    return TextFormField(
      autocorrect: false,
      decoration:
          InputDecoration(labelText: "country", hintText: '나라명을 입력해주세요'),
      validator: (country) {
        if (country.isEmpty) {
          return '나라명을 입력해주세요.';
        }
        return null;
      },
      initialValue: widget.coffeeData.country,
      onSaved: (country) => widget.coffeeData.setCountry = country,
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
      initialValue: widget.coffeeData.city,
      onSaved: (city) => widget.coffeeData.setCity = city,
    );
  }

//body
  Widget bodyField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: "body", hintText: 'body'),
      value: widget.coffeeData.body,
      items: levelList,
      onChanged: (value) {
        setState(() {
          widget.coffeeData.body = value;
        });
      },
      onSaved: (body) => widget.coffeeData.setBody = body,
    );
  }

//acidity
  Widget acidityField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: "acidity", hintText: 'acidity'),
      value: widget.coffeeData.acidity,
      items: levelList,
      onChanged: (value) {
        setState(() {
          widget.coffeeData.acidity = value;
        });
      },
      onSaved: (acidity) => widget.coffeeData.setAcitidy = acidity,
    );
  }

  //acidity
  Widget bitternessField() {
    return DropdownButtonFormField(
      decoration:
          InputDecoration(labelText: "bitterness", hintText: 'bitterness'),
      value: widget.coffeeData.acidity,
      items: levelList,
      onChanged: (value) {
        setState(() {
          widget.coffeeData.bitterness = value;
        });
      },
      onSaved: (bitterness) => widget.coffeeData.setBitterness = bitterness,
    );
  }

  //balance
  Widget balanceField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: "balance", hintText: 'balance'),
      value: widget.coffeeData.balance,
      items: levelList,
      onChanged: (value) {
        setState(() {
          widget.coffeeData.balance = value;
        });
      },
      onSaved: (balance) => widget.coffeeData.setBalance = balance,
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
      initialValue: widget.coffeeData.desc,
      onSaved: (country) => widget.coffeeData.setDesc = country,
    );
  }

  Widget imageField() {
    return TextFormField(
      //obscureText: true,
      decoration:
          InputDecoration(labelText: "image", hintText: '이미지 경로를 입력해주세요'),
      initialValue: widget.coffeeData.image,
      onSaved: (image) => widget.coffeeData.setImage = image,
    );
  }

  // 문서 생성 (Create)
  void createDoc() {
    FirebaseFirestore.instance
        .collection(widget.coffeeData.colName)
        .add(widget.coffeeData.toMap());
    // .then((value) => Navigator.pop(context));
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
}
