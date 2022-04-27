import 'dart:ui';

class Work {
  String name;
  String area;
  String phone;
  double rating;
  Image? image;
  String title;
  String label;
  String description;
  Work(
      {required this.name,
      required this.area,
      required this.phone,
      required this.rating,
      this.image,
      required this.title,
      required this.label,
      required this.description});
}
