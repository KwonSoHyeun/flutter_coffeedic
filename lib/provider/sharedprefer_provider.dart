import 'package:coffeedic/models/coffee.dart';
import 'package:coffeedic/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferProvider {
  Map<String, bool> isSwitchOn = {
    'aroma': false,
    'body': false,
    'sweet': false,
    'acidity': false,
    'bitter': false,
    'balance': false,
  };
  Map<String, int> favoritValue = {
    'aroma': 1,
    'body': 1,
    'sweet': 1,
    'acidity': 1,
    'bitter': 1,
    'balance': 1,
  };

  get_isSwitchOn() {
    return isSwitchOn;
  }

  get_favoritValue() {
    return favoritValue;
  }

  getSwitchOnInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isSwitchOn['aroma'] = (prefs.getBool("o_aroma") ?? false);
    isSwitchOn['body'] = (prefs.getBool("o_body") ?? false);
    isSwitchOn['sweet'] = (prefs.getBool("o_sweet") ?? false);
    isSwitchOn['acidity'] = (prefs.getBool("o_acidity") ?? false);
    isSwitchOn['bitter'] = (prefs.getBool("o_bitter") ?? false);
    isSwitchOn['balance'] = (prefs.getBool("o_balance") ?? false);

    return isSwitchOn;
  }

  getFavoriteValueInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    favoritValue['aroma'] = (prefs.getInt("f_aroma") ?? 1);
    favoritValue['body'] = (prefs.getInt("f_body") ?? 1);
    favoritValue['sweet'] = (prefs.getInt("f_sweet") ?? 1);
    favoritValue['acidity'] = (prefs.getInt("f_acidity") ?? 1);
    favoritValue['bitter'] = (prefs.getInt("f_bitter") ?? 1);
    favoritValue['balance'] = (prefs.getInt("f_balance") ?? 1);
    print("favoritValue[aroma]*" + favoritValue["aroma"].toString());
    return favoritValue;
  }
}
