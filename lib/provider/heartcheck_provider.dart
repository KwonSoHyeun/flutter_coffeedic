import 'package:coffeedic/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeartCheckProvider with ChangeNotifier {
  List<String> heartDocIdList = new List<String>();
  List<Coffee> heartCheckedList = new List<Coffee>();

  initCheckedList(List<Coffee> coffeelist) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    heartDocIdList = (prefs.getStringList("heartIds")) ?? List<String>();
    coffeelist.forEach((element) {
      //print(element.name);
      if (heartDocIdList.contains(element.coffeeId)) {
        heartCheckedList.add(element);
      }
    });
  }

  addCheckedDocList(String documentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    heartDocIdList = (prefs.getStringList("heartIds")) ?? List<String>();
    if (!heartDocIdList.contains(documentId)) {
      heartDocIdList.add(documentId);
      prefs.setStringList("heartIds", heartDocIdList);
      notifyListeners();
    }
  }

  removeCheckedDocList(String documentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    heartDocIdList = (prefs.getStringList("heartIds")) ?? List<String>();
    if (heartDocIdList.contains(documentId)) {
      heartDocIdList.remove(documentId);
      prefs.setStringList("heartIds", heartDocIdList);
      notifyListeners();
    }
  }
}
