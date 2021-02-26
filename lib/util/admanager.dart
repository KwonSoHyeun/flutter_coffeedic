import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_ADMOB_APP_ID>";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8520099320288331~9511703914D";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_BANNER_AD_UNIT_ID";
    } else if (Platform.isIOS) {
      //return "ca-app-pub-8520099320288331/9128011795";
      //ca-app-pub-3940256099942544/4339318960//for test
      return "ca-app-pub-3940256099942544/2934735716"; //for test
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
