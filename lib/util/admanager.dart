import 'dart:io';

class AdManager {
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
