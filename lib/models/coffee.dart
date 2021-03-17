import 'package:flutter/material.dart';

class Coffee {
  static String colName = "coffeebasic";
  String coffeeId;

// 필드명 ....
  static String fnName = "name";
  static String fnNameEn = "name_en";
  static String fnCountry = "country";
  static String fnCountryEn = "country_en";
  static String fnCity = "city";
  static String fnCityEn = "city_en";
  static String fnAroma = "aroma";
  static String fnBody = "body";
  static String fnSweet = "sweet";
  static String fnAcidity = "acidity";
  static String fnBitterness = "bitterness";
  static String fnBalance = "balance";
  static String fnDesc = "desc";
  static String fnDescEn = "desc_en";
  static String fnImage = "image";

  String name = "";
  String country = "";
  String city = "";
  String nameEn = "";
  String countryEn = "";
  String cityEn = "";
  String descEn = "";
  int aroma = 3;
  int body = 3;
  int sweet = 3;
  int acidity = 3;
  int bitterness = 3;
  int balance = 3;
  String desc = "";
  String image = "";

  set setName(String str) {
    this.name = str;
  }

  set setCountry(String str) {
    this.country = str;
  }

  set setCity(String str) {
    this.city = str;
  }

  set setAroma(int aroma) {
    this.aroma = aroma;
  }

  set setBody(int body) {
    this.body = body;
  }

  set setSweet(int value) {
    this.sweet = value;
  }

  set setAcidity(int value) {
    this.acidity = value;
  }

  set setBitterness(int value) {
    this.bitterness = value;
  }

  set setBalance(int value) {
    this.balance = value;
  }

  set setDesc(String str) {
    this.desc = str;
  }

  set setImage(String str) {
    this.image = str;
  }

  //for English

  set setNameEn(String str) {
    this.nameEn = str;
  }

  set setCountryEn(String str) {
    this.countryEn = str;
  }

  set setCityEn(String str) {
    this.cityEn = str;
  }

  set setDescEn(String str) {
    this.descEn = str;
  }

  showMessage() {
    //print("COFFEESHOW:::"+)
  }

  Coffee(
      {this.name,
      this.nameEn,
      this.country,
      this.countryEn,
      this.city,
      this.cityEn,
      this.aroma,
      this.body,
      this.sweet,
      this.acidity,
      this.bitterness,
      this.balance,
      this.desc,
      this.descEn,
      this.image});

  Coffee.initiate() {
    name = "";
    nameEn = "";
    country = "";
    countryEn = "";
    city = "";
    cityEn = "";
    aroma = 3;
    body = 3;
    sweet = 3;
    acidity = 3;
    bitterness = 3;
    balance = 3;
    desc = "";
    descEn = "";
    image = "";
  }

  Map<String, dynamic> toMap() {
    return {
      'coffeeId': coffeeId,
      fnName: name,
      fnNameEn: nameEn,
      fnCountry: country,
      fnCountryEn: countryEn,
      fnCity: city,
      fnCityEn: cityEn,
      fnAroma: aroma,
      fnBody: body,
      fnSweet: sweet,
      fnAcidity: acidity,
      fnBitterness: bitterness,
      fnBalance: balance,
      fnDesc: desc,
      fnDescEn: descEn,
      fnImage: image
    };
  }

  Coffee.setFromFirestore(Map<String, dynamic> firestore) {
    name = firestore[fnName];
    nameEn = firestore[fnName];
    country = firestore[fnCountry];
    countryEn = firestore[fnCountryEn];
    city = firestore[fnCity];
    cityEn = firestore[fnCityEn];

    aroma = firestore[fnAroma];
    body = firestore[fnBody];
    sweet = firestore[fnSweet];
    acidity = firestore[fnAcidity];
    bitterness = firestore[fnBitterness];
    balance = firestore[fnBalance];
    desc = firestore[fnDesc];
    descEn = firestore[fnDescEn];
    image = firestore[fnImage];
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
      : name = firestore[fnName],
        nameEn = firestore[fnNameEn],
        country = firestore[fnCountry],
        countryEn = firestore[fnCountryEn],
        city = firestore[fnCity],
        cityEn = firestore[fnCityEn],
        aroma = firestore[fnAroma],
        body = firestore[fnBody],
        sweet = firestore[fnSweet],
        acidity = firestore[fnAcidity],
        bitterness = firestore[fnBitterness],
        balance = firestore[fnBalance],
        desc = firestore[fnDesc],
        descEn = firestore[fnDescEn],
        image = firestore[fnImage];

  Coffee.fromFirestoreWithId(String documentId, Map<String, dynamic> firestore)
      : coffeeId = documentId,
        name = firestore[fnName],
        nameEn = firestore[fnNameEn],
        country = firestore[fnCountry],
        countryEn = firestore[fnCountryEn],
        city = firestore[fnCity],
        cityEn = firestore[fnCityEn],
        aroma = firestore[fnAroma],
        body = firestore[fnBody],
        sweet = firestore[fnSweet],
        acidity = firestore[fnAcidity],
        bitterness = firestore[fnBitterness],
        balance = firestore[fnBalance],
        desc = firestore[fnDesc],
        descEn = firestore[fnDescEn],
        image = firestore[fnImage];
}
