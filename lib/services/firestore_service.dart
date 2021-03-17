import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeedic/models/coffee.dart';
import 'package:flutter/material.dart';

class FirestoreService with ChangeNotifier {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  //Coffee _coffee = new Coffee();

  Future<void> addProduct(Coffee product) {
    return _db.collection(Coffee.colName).add(product.toMap());
  }

  Future<void> saveProduct(Coffee product) {
    return _db
        .collection(Coffee.colName)
        .doc(product.coffeeId)
        .set(product.toMap());
  }

  int favoriteItemCount = 0;

  int getFavoriteItemCount() {
    //print("getFavoriteItemCount:called");

    return favoriteItemCount;
  }

  List<Coffee> favoriteValuesFilter(
      List<Coffee> coffeelist, Map isswichon, Map myfavorite) {
    List<Coffee> filteredlist = new List<Coffee>();

    for (int i = 0; i < coffeelist.length; i++) {
      var element = coffeelist[i];
      if (!isswichon["aroma"] ||
          (isswichon["aroma"] && element.aroma == myfavorite["aroma"])) {
      } //next 조건 탐색}
      else
        continue;
      if (!isswichon["body"] ||
          (isswichon["body"] && element.body == myfavorite["body"])) {
      } //next 조건 탐색}
      else
        continue;
      if (!isswichon["sweet"] ||
          (isswichon["sweet"] && element.sweet == myfavorite["sweet"])) {
      } //next 조건 탐색}
      else
        continue;
      if (!isswichon["acidity"] ||
          (isswichon["acidity"] && element.acidity == myfavorite["acidity"])) {
      } //next 조건 탐색}
      else
        continue;
      if (!isswichon["bitter"] ||
          (isswichon["bitter"] &&
              element.bitterness == myfavorite["bitterness"])) {
      } //next 조건 탐색}
      else
        continue;
      if (!isswichon["balance"] ||
          (isswichon["balance"] && element.aroma == myfavorite["balance"])) {
        filteredlist.add(element);
      } //next 조건 탐색}
      else
        continue;
    }
    //print("length:" + filteredlist.length.toString());
    favoriteItemCount = filteredlist.length;

    return filteredlist;
  }

  Stream<List<Coffee>> getCoffees() {
    return _db
        .collection(Coffee.colName)
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((document) {
        return Coffee.fromFirestoreWithId(document.id, document.data());
      }).toList();
    });
  }

  List<Coffee> keywordFilter(List<Coffee> coffeelist, String keyword) {
    final bool isKo = (Platform.localeName == "ko_KR");
    List<Coffee> filteredlist = new List<Coffee>();

    coffeelist.forEach((element) {
      element.name = isKo ? element.name : element.nameEn;
      element.country = isKo ? element.country : element.countryEn;
      element.city = isKo ? element.city : element.cityEn;
      element.desc = isKo ? element.desc : element.descEn;

      if (element.name.toUpperCase().contains(keyword.toUpperCase())) {
        filteredlist.add(element);
      }
    });

    return filteredlist;
  }

  Future<void> removeProduct(String docID) {
    return _db.collection(Coffee.colName).doc(docID).delete();
  }
}
