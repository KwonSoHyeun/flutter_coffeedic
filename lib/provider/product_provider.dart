import 'package:coffeedic/models/coffee.dart';
import 'package:coffeedic/services/firestore_service.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _coffeeId;
  String _name;
  String _country;
  String _city;
  String _acidity;
  String _balance;
  String _bitterness;
  String _body;
  String _desc;
  String _image;

  //Getter
  String get name => _name;
  String get country => _country;
  String get city => _city;
  String get acidity => _acidity;
  String get balance => _balance;
  String get bitterness => _bitterness;
  String get body => _body;
  String get desc => _desc;
  String get image => _image;

  //Setters
  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changeCountry(String value) {
    _country = value;
    notifyListeners();
  }

  changeCity(String value) {
    _city = value;
    notifyListeners();
  }

  changeAcidity(String value) {
    _acidity = value;
    notifyListeners();
  }

  changeBalance(String value) {
    _balance = value;
    notifyListeners();
  }

  changeBitterness(String value) {
    _bitterness = value;
    notifyListeners();
  }

  changeBody(String value) {
    _body = value;
    notifyListeners();
  }

  changeDesc(String value) {
    _desc = value;
    notifyListeners();
  }

  changeImage(String value) {
    _image = value;
    notifyListeners();
  }

  loadValues(Coffee product) {
    print("##########loadValues" + _coffeeId.toString());
    _coffeeId = product.coffeeId;
    _name = product.name;
    _country = product.country;
    _city = product.city;
    _acidity = product.acidity;
    _balance = product.balance;
    _bitterness = product.bitterness;
    _body = product.body;
    _desc = product.desc;
    _image = product.image;
  }

  saveProduct() {
    print("saveProduct" + _coffeeId);

    if (_coffeeId == null) {
      var newCoffee = Coffee(
          //todo : coffeeId: _coffeeId,
          name: name,
          country: country,
          city: city,
          acidity: acidity,
          balance: balance,
          bitterness: bitterness,
          body: body,
          desc: desc,
          image: image);
      firestoreService.saveProduct(newCoffee);
    } else {
      var updatedProduct = Coffee(
          coffeeId: _coffeeId,
          name: _name,
          country: _country,
          city: _city,
          acidity: _acidity,
          balance: _balance,
          bitterness: _bitterness,
          body: _body,
          desc: _desc,
          image: _image);
      firestoreService.saveProduct(updatedProduct);
    }
  }

  removeProduct(String coffeeId) {
    firestoreService.removeProduct(coffeeId);
  }
}
