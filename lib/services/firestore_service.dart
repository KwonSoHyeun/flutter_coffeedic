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

  Stream<List<Coffee>> getProducts() {
    return _db.collection(_coffee.colName).snapshots().map((snapshot) {
      return snapshot.docs.map((document) {
        return Coffee.fromFirestore(document.data());
      }).toList();
    });
  }

  Stream<List<Coffee>> getCoffees() {
    return _db.collection(_coffee.colName).snapshots().map((snapshot) {
      return snapshot.docs.map((document) {
        return Coffee.fromFirestoreWithId(document.id, document.data());
      }).toList();
    });
  }

  List<Coffee> keywordFilter(List<Coffee> coffeelist, String keyword) {
    var filteredlist = new List<Coffee>();

    coffeelist.forEach((element) {
      if (element.name.contains(keyword)) {
        filteredlist.add(element);
      }
    });
    return filteredlist;
  }

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
