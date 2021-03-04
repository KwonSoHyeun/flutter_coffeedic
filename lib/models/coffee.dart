import 'package:flutter/material.dart';

class Coffee {
  final String colName = "coffeebasic";
  String coffeeId;

// 필드명 ....
  final String fnName = "name";
  final String fnCountry = "country";
  final String fnCity = "city";
  final String fnAroma = "aroma";
  final String fnBody = "body";
  final String fnSweet = "sweet";
  final String fnAcidity = "acidity";
  final String fnBitterness = "bitterness";
  final String fnBalance = "balance";
  final String fnDesc = "desc";
  final String fnImage = "image";

  String name = "";
  String country = "";
  String city = "";
  int aroma = 3;
  int body = 3;
  int sweet = 3;
  int acidity = 3;
  int bitterness = 3;
  int balance = 3;
  String desc = "";
  String image = "";

  set setName(String name) {
    this.name = name;
  }

  set setCountry(String country) {
    this.country = country;
  }

  set setCity(String city) {
    this.city = city;
  }

  set setAroma(int aroma) {
    this.aroma = aroma;
  }

  set setBody(int body) {
    this.body = body;
  }

  set setSweet(int sweet) {
    this.sweet = sweet;
  }

  set setAcidity(int acidity) {
    this.acidity = acidity;
  }

  set setBitterness(int bitterness) {
    this.bitterness = bitterness;
  }

  set setBalance(int balance) {
    this.balance = balance;
  }

  set setDesc(String desc) {
    this.desc = desc;
  }

  set setImage(String image) {
    this.image = image;
  }

  showMessage() {
    //print("COFFEESHOW:::"+)
  }

  Coffee(
      {this.name,
      this.country,
      this.city,
      this.aroma,
      this.body,
      this.sweet,
      this.acidity,
      this.bitterness,
      this.balance,
      this.desc,
      this.image});

  Coffee.initiate() {
    name = "";
    country = "";
    city = "";
    aroma = 3;
    body = 3;
    sweet = 3;
    acidity = 3;
    bitterness = 3;
    balance = 3;
    desc = "";
    image = "";
  }

  Map<String, dynamic> toMap() {
    return {
      'coffeeId': coffeeId,
      'name': name,
      'country': country,
      'city': city,
      'aroma': aroma,
      'body': body,
      'sweet': sweet,
      'acidity': acidity,
      'bitterness': bitterness,
      'balance': balance,
      'desc': desc,
      'image': image
    };
  }

  Coffee.setFromFirestore(Map<String, dynamic> firestore) {
    name = firestore['name'];
    country = firestore['country'];
    city = firestore['city'];
    aroma = firestore['aroma'];
    // body = firestore['body'].toInt();
    // sweet = firestore['sweet'].toInt();
    // acidity = firestore['acidity'].toInt();
    // bitterness = firestore['bitterness'].toInt();
    // balance = firestore['balance'].toInt();
    body = firestore['body'];
    sweet = firestore['sweet'];
    acidity = firestore['acidity'];
    bitterness = firestore['bitterness'];
    balance = firestore['balance'];
    desc = firestore['desc'];
    image = firestore['image'];
  }

  List<DropdownMenuItem<int>> loadLevelList() {
    List<DropdownMenuItem<int>> levelList = [];

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

    return levelList;
  }

  Coffee.fromFirestore(Map<String, dynamic> firestore)
      : name = firestore['name'],
        country = firestore['country'],
        city = firestore['city'],
        aroma = firestore['aroma'],
        body = firestore['body'],
        sweet = firestore['sweet'],
        acidity = firestore['acidity'],
        bitterness = firestore['bitterness'],
        balance = firestore['balance'],
        desc = firestore['desc'],
        image = firestore['image'];

  Coffee.fromFirestoreWithId(String documentId, Map<String, dynamic> firestore)
      : coffeeId = documentId,
        name = firestore['name'],
        country = firestore['country'],
        city = firestore['city'],
        aroma = firestore['aroma'],
        body = firestore['body'],
        sweet = firestore['sweet'],
        acidity = firestore['acidity'],
        bitterness = firestore['bitterness'],
        balance = firestore['balance'],
        desc = firestore['desc'],
        image = firestore['image'];
}
