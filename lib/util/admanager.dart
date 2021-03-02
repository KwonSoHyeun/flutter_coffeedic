import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

class AdManager {
  //AdmobBanner _bannerAd;

  // init() async {
  //  // FirebaseAdMob.instance.initialize(appId: appID);
  //   //_bannerAd = createBannerAd();
  // }

  AdmobBanner createBannerAd() {
    return AdmobBanner(
        adUnitId: AdManager.bannerAdUnitId,
        adSize: AdmobBannerSize.BANNER,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          print(event);
          print(args);
        });
  }

  Widget bannerContainer() {
    return Padding(
        padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
        child: InkWell(
            child: Container(
                // height: 50,
                child: createBannerAd())));
  }

  // Widget bannerContainer() {
  //   return Padding(
  //       padding: const EdgeInsets.only(bottom: 0.0),
  //       child: InkWell(
  //           child: Container(
  //               // height: 50,
  //               child: AdmobBanner(
  //                   adUnitId: AdManager.bannerAdUnitId,
  //                   adSize: AdmobBannerSize.BANNER,
  //                   listener: (AdmobAdEvent event, Map<String, dynamic> args) {
  //                     print(event);
  //                     print(args);
  //                     //handleEvent();
  //                   }))));
  // }

  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8520099320288331~3155330504";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8520099320288331~9511703914D";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      //return "ca-app-pub-8520099320288331/6388639134";
      return "ca-app-pub-3940256099942544/6300978111"; //for test
    } else if (Platform.isIOS) {
      //return "ca-app-pub-8520099320288331/9128011795";
      return "ca-app-pub-3940256099942544/2934735716"; //for test
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
