class Review {
  String uid;
  String reviewerUid;
  String meisterUid;
  //TODO: delete these
  String reviewerName;
  String area;
  String phone;

  double rating;
  Review(
      {this.uid = "",
      this.reviewerUid = "",
      this.meisterUid = "",
      this.reviewerName = "",
      this.area = "",
      this.phone = "",
      this.rating = 0});
}
