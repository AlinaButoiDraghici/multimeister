class Meister {
  String uid = "";
  String userID = "";
  double rating = 0;
  //lists containing work uids
  List<String> workList = List.empty();

  Meister({
    required this.uid,
    required this.userID,
  });

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "userID": userID,
        "rating": rating,
        "workList": workList,
      };

  Meister.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    userID = map["userID"];
    rating = map["rating"];
    workList = map["workList"];
  }
}
