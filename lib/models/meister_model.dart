import 'package:multimeister/models/review_model.dart';
import 'package:multimeister/models/work_model.dart';

class Meister {
  String uid = "";
  String userID = "";
  List<Work> workList = List.empty();
  List<Review> reviewList = List.empty();
  Meister({
    required this.uid,
    required this.userID,
  });
}
