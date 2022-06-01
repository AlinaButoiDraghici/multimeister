import 'package:multimeister/models/review_model.dart';
import 'package:multimeister/services/database.dart';

class Work {
  String uid = "";
  //TODO: delete these
  String meisterName = "";
  String meisterCity = "";
  String meisterPhone = "";

  List<String>? reviewList = List<String>.empty();
  double? rating = 0;
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
      this.reviewList,
      required this.rating,
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
        "reviewList": reviewList,
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
    reviewList = map["reviewList"];
  }
  
  void updateReviews(){
    try {
      DatabaseService databaseService = DatabaseService();
      List<Review> reviews = databaseService.getWorkItemReviews(uid) as List<Review>;

      double score = 0;
      for(Review review in reviews){
        reviewList!.add(review.uid);
        score += review.rating;
      }

      rating = score / reviews.length;
    } catch(e) {
      print(e);
    }
  }
}
