import 'package:multimeister/models/review_model.dart';
import 'package:multimeister/models/work_model.dart';

class Meister {
  String uid = "";
  String userID = "";
  //lists containing work and review uids
  List<String> workList = List.empty();
  List<String> reviewList = List.empty();
  Meister({
    required this.uid,
    required this.userID,
  });

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "userID": userID,
        "workList": workList,
        "reviewList": reviewList,
      };

  Meister.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    userID = map["userID"];
    workList = map["workList"];
    reviewList = map["reviewList"];
  }
}
