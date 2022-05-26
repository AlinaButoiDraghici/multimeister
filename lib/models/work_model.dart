class Work {
  String uid = "";
  //TODO: delete these
  String meisterName = "";
  String meisterCity = "";
  String meisterPhone = "";

  double? rating;
  double price = 0;
  List<String>? images;
  String title = "";
  String label = "";
  String description = "";
  String meisterUid = "";
  Work(
      {required this.meisterUid,
      required this.uid,
      required this.meisterName,
      required this.meisterCity,
      required this.meisterPhone,
      this.rating,
      required this.price,
      this.images,
      required this.title,
      required this.label,
      required this.description});

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "meisterName": meisterName,
        "meisterCity": meisterCity,
        "meisterPhone": meisterPhone,
        "rating": rating,
        "price": price,
        "images": images,
        "title": title,
        "description": description,
        "label": label,
        "meisterUid": meisterUid,
      };

  Work.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    meisterName = map["meisterName"];
    meisterCity = map["meisterCity"];
    meisterPhone = map["meisterPhone"];
    rating = map["rating"];
    price = map["price"];
    images = map["images"];
    title = map["title"];
    description = map["description"];
    label = map["label"];
    meisterUid = map["meisterUid"];
  }
}
