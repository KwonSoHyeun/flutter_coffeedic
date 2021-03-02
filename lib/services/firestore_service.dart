import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeedic/models/coffee.dart';
//import 'package:coffeedic/provider/sharedprefer_provider.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';

class FirestoreService with ChangeNotifier {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Coffee _coffee = new Coffee();

  Future<void> addProduct(Coffee product) {
    return _db.collection(_coffee.colName).add(product.toMap());
  }

  Future<void> saveProduct(Coffee product) {
    return _db
        .collection(_coffee.colName)
        .doc(product.coffeeId)
        .set(product.toMap());
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
    return filteredlist;
  }

// //index 문제때문에 변경해야 함
//   Stream getFavoritCoffees(Map isswichon, Map myfavorite) {
//     Query query = _db.collection(_coffee.colName).orderBy('name');

//     if (isswichon["aroma"])
//       query = query.where('aroma', isEqualTo: myfavorite["aroma"]);
//     if (isswichon["body"])
//       query = query.where('body', isEqualTo: myfavorite["body"]);
//     if (isswichon["sweet"])
//       query = query.where('sweet', isEqualTo: myfavorite["sweet"]);
//     if (isswichon["acidity"])
//       query = query.where('acidity', isEqualTo: myfavorite["acidity"]);
//     if (isswichon["bitter"])
//       query = query.where('bitter', isEqualTo: myfavorite["bitter"]);
//     if (isswichon["balance"])
//       query = query.where('balance', isEqualTo: myfavorite["balance"]);

//     return query.snapshots();
//   }

  Stream<List<Coffee>> getCoffees() {
    return _db
        .collection(_coffee.colName)
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((document) {
        return Coffee.fromFirestoreWithId(document.id, document.data());
      }).toList();
    });
  }

  List<Coffee> keywordFilter(List<Coffee> coffeelist, String keyword) {
    List<Coffee> filteredlist = new List<Coffee>();

    coffeelist.forEach((element) {
      //print(element.name);
      if (element.name.contains(keyword)) {
        filteredlist.add(element);
      }
    });
    return filteredlist;
  }

//
  //   List<Coffee> favoriteFilter(List<Coffee> coffeelist) {
  //   List<Coffee> filteredlist = new List<Coffee>();

  //   coffeelist.forEach((element) {
  //     if (element.name.contains(keyword)) {
  //       filteredlist.add(element);
  //     }
  //   });
  //   return filteredlist;
  // }

  // List<Coffee> filtedCoffeeList(List<Coffee> products) {
  //   List<Coffee> coffeeproduct = new List<Coffee>();
  //   if (products != null) coffeeproduct.addAll(products);
  //   return coffeeproduct;
  // }

  List<Coffee> favoriteFilter(List<Coffee> coffeelist, Map myfavorite) {
    var filteredlist = new List<Coffee>();

    // coffeelist.forEach((element) {
    //   if (element.name.contains(keyword)) {
    //     filteredlist.add(element);
    //   }
    // });
    return filteredlist;
  }

  Future<void> removeProduct(String docID) {
    return _db.collection(_coffee.colName).doc(docID).delete();
  }

  //  // 문서 삭제 (Delete)
  // void deleteDoc(String docID) {
  //   Firestore.instance.collection(colName).document(docID).delete();
  // }
}
