import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeedic/models/coffee.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addProduct(Coffee product) {
    return _db.collection(Coffee.colName).add(product.toMap());
  }

  Future<void> saveProduct(Coffee product) {
    return _db
        .collection(Coffee.colName)
        .doc(product.coffeeId)
        .set(product.toMap());
  }

  Stream<List<Coffee>> getProducts() {
    return _db.collection(Coffee.colName).snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => Coffee.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeProduct(String docID) {
    return _db.collection(Coffee.colName).doc(docID).delete();
  }

  //  // 문서 삭제 (Delete)
  // void deleteDoc(String docID) {
  //   Firestore.instance.collection(colName).document(docID).delete();
  // }
}
