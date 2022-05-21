import 'package:hive/hive.dart';

part 'hive_user.g.dart';

@HiveType(typeId: 0)
class HiveUser extends HiveObject {
  @HiveField(0)
  late String uid;
  @HiveField(1)
  late String? email;
  @HiveField(2)
  late String? firstName;
  @HiveField(3)
  late String? lastName;
  @HiveField(4)
  late String? phone;
  @HiveField(5)
  late String? city;
  @HiveField(6)
  late bool? isMeister;
  @HiveField(7)
  late String? profilePicture;
  @HiveField(8)
  late String? meisterID;
  HiveUser(
      {required this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.phone,
      this.city,
      this.isMeister,
      this.profilePicture,
      this.meisterID});
}
