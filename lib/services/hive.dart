import 'package:hive/hive.dart';
import 'package:multimeister/models/base_user.dart';
import 'package:multimeister/models/hive_user.dart';

class HiveServices {
  late final Box<HiveUser> userBox;

  static final HiveServices _instance = HiveServices._internal();

  factory HiveServices() => _instance;

  HiveServices._internal();

  Future<void> initHive() async {
    Hive.registerAdapter(HiveUserAdapter());
    userBox = await Hive.openBox<HiveUser>('userBox');
  }

  HiveUser? getUserData() => userBox.get('user');

  void addUserToBox(BaseUser baseUser) {
    final newUser = HiveUser(
        uid: baseUser.uid,
        email: baseUser.email,
        firstName: baseUser.firstName,
        lastName: baseUser.lastName,
        phone: baseUser.phone,
        city: baseUser.city,
        isMeister: baseUser.isMeister,
        profilePicture: baseUser.profilePicture,
        meisterID: baseUser.meisterID);
    _instance.userBox.put('user', newUser);
  }

  Future<void> removeUserFromBox() async {
    await _instance.userBox.clear();
  }
}
