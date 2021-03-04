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
    //asyc 이면서 배열값을 리턴하기에 future를 써서 받는쪽에서 어렵다.
    initHeartCheck(coffeelist);
    return heartCheckedList;
  }

  void initHeartCheck(List<Coffee> coffeelist) async {
    heartCheckedList.clear();
    coffeelist.forEach((element) {
      if (heartDocIdList.contains(element.coffeeId)) {
        heartCheckedList.add(element);
      }
    });
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
