class Review {
  String uid = "";
  String reviewerUid = "";
  String reviewerName = "";
  String meisterUid = "";
  String workItemUid = "";

  double rating = 0;
  Review(
      {required this.uid,
      required this.reviewerUid,
      required this.reviewerName,
      required this.meisterUid,
      required this.workItemUid,
      required this.rating});
  
  Review.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    reviewerUid = map["userUid"];
    reviewerName = map["reviewerName"];
    meisterUid = map["meisterUid"];
    workItemUid = map["workItemUid"];
    rating = map["rating"];
  }

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "meisterUid": meisterUid,
        "reviewerUid": reviewerUid,
        "reviewerName": reviewerName,
        "workItemUid": workItemUid,
        "rating": rating,
      };
}
