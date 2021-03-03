import 'package:coffeedic/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeartCheckProvider with ChangeNotifier {
  final String heartKey = "HEARTID";
  List<String> heartDocIdList = new List<String>();
  List<Coffee> heartCheckedList = new List<Coffee>();

  Future<List<Coffee>> getCheckedList(List<Coffee> coffeelist) async {
    heartCheckedList.clear();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    heartDocIdList = (prefs.getStringList(heartKey)) ?? List<String>();
    coffeelist.forEach((element) {
      if (heartDocIdList.contains(element.coffeeId)) {
        heartCheckedList.add(element);
        print("heartCheckedList::" + element.name);
      }
    });
    return heartCheckedList;
  }
  // initCheckedList(List<Coffee> coffeelist) async {
  //   heartCheckedList.clear();

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   heartDocIdList = (prefs.getStringList(heartKey)) ?? List<String>();
  //   coffeelist.forEach((element) {
  //     if (heartDocIdList.contains(element.coffeeId)) {
  //       heartCheckedList.add(element);
  //       print("heartCheckedList::" + element.name);
  //     }
  //   });
  // }

  addCheckedDocList(String documentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    heartDocIdList = (prefs.getStringList(heartKey)) ?? List<String>();
    if (!heartDocIdList.contains(documentId)) {
      heartDocIdList.add(documentId);
      prefs.setStringList(heartKey, heartDocIdList);
      notifyListeners();
    }

    print("length::::" + heartDocIdList.length.toString());
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
