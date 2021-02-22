import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeedic/models/coffee.dart';
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

/*
 Stream<List<User>> getUsers() {
    // DocumentSnapshot 으로 되어 있기에 이를 리스트 형식으로 바꿔줌.
    return _db.collection('user').snapshots().map((list) =>
        list.documents.map((doc) => User.fromFireStore(doc)).toList());
  }
*/
  // stream: Firestore.instance.collection('kontakt')
  //                 .orderBy(sortby, descending: decending).snapshots(),

  Stream getFavoritCoffees() {
    //sharedpreference 값을 가져와서 조건식을 만든다.
    return _db
        .collection(_coffee.colName)
        .where('sweet', isEqualTo: 4)
        .snapshots();
  }
  // Stream<List<Coffee>> getFavoritCoffees() {
  //   return _db
  //       .collection(_coffee.colName)
  //       .where('sweet', isEqualTo: 3)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((document) {
  //       return Coffee.fromFirestore(document.data());
  //     }).toList();
  //   });
  // }

  Stream<List<Coffee>> getCoffees() {
    return _db.collection(_coffee.colName).snapshots().map((snapshot) {
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
