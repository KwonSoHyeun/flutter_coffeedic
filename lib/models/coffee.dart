class Coffee {
  final String colName = "coffeebasic";

  // 필드명 ....
  String coffeeId = null;
  final String fnName = "name";
  final String fnCountry = "country";
  final String fnCity = "city";
  final String fnBody = "body";
  final String fnAcidity = "acidity";
  final String fnBitterness = "bitterness";
  final String fnBalance = "balance";
  final String fnDesc = "desc";
  final String fnImage = "image";

  String name = "";
  String country = "";
  String city = "";
  int body = 3;
  int acidity = 3;
  int bitterness = 3;
  int balance = 3;
  String desc = "";
  String image = "";

  set setName(String name) {
    this.name = name;
  }

  set setCountry(String country) {
    this.country = country;
  }

  set setCity(String city) {
    this.city = city;
  }

  set setBody(int body) {
    this.body = body;
  }

  set setAcitidy(int acitidy) {
    this.acidity = acitidy;
  }

  set setBitterness(int bitterness) {
    this.bitterness = bitterness;
  }

  set setBalance(int balance) {
    this.balance = balance;
  }

  set setDesc(String desc) {
    this.desc = desc;
  }

  set setImage(String image) {
    this.image = image;
  }

  showMessage() {
    //print("COFFEESHOW:::"+)
  }

  Coffee(
      {this.name,
      this.country,
      this.city,
      this.body,
      this.acidity,
      this.bitterness,
      this.balance,
      this.desc,
      this.image});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'country': country,
      'city': city,
      'body': body,
      'acidity': acidity,
      'bitterness': bitterness,
      'balance': balance,
      'desc': desc,
      'image': image
    };
  }

  Coffee.fromFirestore(Map<String, dynamic> firestore)
      : name = firestore['name'],
        country = firestore['country'],
        city = firestore['city'],
        body = firestore['body'],
        acidity = firestore['acidity'],
        bitterness = firestore['bitterness'],
        balance = firestore['balance'],
        desc = firestore['desc'],
        image = firestore['image'];
}
