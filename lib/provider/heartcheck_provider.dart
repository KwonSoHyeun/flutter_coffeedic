import 'package:coffeedic/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeartCheckProvider with ChangeNotifier {
  final String heartKey = "HEARTID";
  List<String> heartDocIdList = new List<String>();
  List<Coffee> heartCheckedList = new List<Coffee>();

  HeartCheckProvider() {
    _init();
  }

  void _init() async {
    heartDocIdList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    heartDocIdList = (prefs.getStringList(heartKey)) ?? List<String>();
  }

  List<Coffee> getHeartList(List<Coffee> coffeelist) {
    heartCheckedList.clear();
    heartDocIdList.forEach((element) {
      int index = -1;
      index = coffeelist.indexWhere((data) => data.coffeeId == element);
      if (index >= 0) {
        heartCheckedList.add(coffeelist[index]);
      }
    });

    return heartCheckedList;
  }

  bool isHeart(String documentId) {
    if (heartDocIdList.contains(documentId))
      return true;
    else
      return false;
  }

  addCheckedDocList(String documentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    heartDocIdList = (prefs.getStringList(heartKey)) ?? List<String>();
    if (!heartDocIdList.contains(documentId)) {
      heartDocIdList.add(documentId);
      prefs.setStringList(heartKey, heartDocIdList);
      notifyListeners();
    }
  }

  removeCheckedDocList(String documentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    heartDocIdList = (prefs.getStringList(heartKey)) ?? List<String>();
    if (heartDocIdList.contains(documentId)) {
      heartDocIdList.remove(documentId);
      prefs.setStringList(heartKey, heartDocIdList);
      notifyListeners();
    }
  }
}
