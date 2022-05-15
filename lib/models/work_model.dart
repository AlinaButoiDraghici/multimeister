import 'dart:ui';

class Work {
  String uid;
  //TODO: delete these
  String name;
  String area;
  String phone;

  double rating;
  List<Image>? images;
  String title;
  String label;
  String description;
  String meisterUid;
  Work(
      {this.uid = "",
      this.meisterUid = "",
      required this.name,
      required this.area,
      required this.phone,
      required this.rating,
      this.images,
      required this.title,
      required this.label,
      required this.description});
}
