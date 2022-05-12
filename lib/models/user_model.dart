class User {
  String uid;
  String email;
  String firstName;
  String lastName;
  String phone;
  String area;
  bool isMeister;
  String? meisterUid;

  User(
      {this.uid = "",
      this.email = "",
      this.firstName = "",
      this.lastName = "",
      this.phone = "",
      this.area = "",
      this.isMeister = false,
      this.meisterUid});
}
