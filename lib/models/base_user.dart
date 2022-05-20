import 'package:uuid/uuid.dart';

class BaseUser {
  String uid = "";
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? city;
  bool? isMeister;
  String? meisterID;
  String? profilePicture;

  //BaseUser({required this.uid});
  BaseUser(
      {required this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.phone,
      this.city,
      this.isMeister,
      this.profilePicture}) {
    if (isMeister == true) {
      var uuid = Uuid();

      meisterID = uuid.v1();
    }
  }

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "city": city,
        "profilePicture": profilePicture,
        "isMeister": isMeister,
        "meisterID": meisterID
      };

  BaseUser.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    email = map["email"];
    firstName = map["firstName"];
    lastName = map["lastName"];
    phone = map["phone"];
    city = map["city"];
    profilePicture = map["profilePicture"];
    isMeister = map["isMeister"];
    meisterID = map["meisterID"];
  }
}
