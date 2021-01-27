class Coffee {
  static final String colName = "coffeebasic";

  // 필드명
  final String coffeeId;
  final String name;
  final String country;
  final String city;
  final String body;
  final String acidity;
  final String bitterness;
  final String balance;
  final String desc;
  final String image;

  Coffee(
      {this.coffeeId,
      this.name,
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
      'coffeeId': coffeeId,
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
      : coffeeId = firestore['coffeeId'],
        name = firestore['name'],
        country = firestore['country'],
        city = firestore['city'],
        body = firestore['body'],
        acidity = firestore['acidity'],
        bitterness = firestore['bitterness'],
        balance = firestore['balance'],
        desc = firestore['desc'],
        image = firestore['image'];
}
