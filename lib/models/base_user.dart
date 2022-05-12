import 'package:uuid/uuid.dart';

class BaseUser{
  String uid = "";
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNo;
  String? address;
  bool? isMeister;
  String? meisterID;

  BaseUser({ required this.uid});
  // BaseUser({ required this.uid, 
  //   required this.email, 
  //   required this.firstName, 
  //   required this.lastName,
  //   required this.phoneNo,
  //   this.address,
  //   required this.isMeister,
  // }) {
  //   if(isMeister == true){
  //     var uuid = Uuid();

  //     meisterID = uuid.v1();
  //   }
  // }

  Map<String, dynamic> toMap() => {
    "uid": uid,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "phoneNo": phoneNo,
    "address": address,
    "isMeister": isMeister,
    "meisterID": meisterID
  };

  BaseUser.fromMap(Map<String, dynamic> map){
    uid = map["uid"];
    email = map["email"];
    firstName = map["firstName"];
    lastName = map["lastName"];
    phoneNo = map["phoneNo"];
    address = map["address"];
    isMeister = map["isMeister"];
    meisterID = map["meisterID"];
  }
}