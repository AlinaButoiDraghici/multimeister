import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multimeister/models/base_user.dart';

class DatabaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference meisterCollection =
      FirebaseFirestore.instance.collection('meisters');
  final CollectionReference workItemCollection =
      FirebaseFirestore.instance.collection('workItems');
  final CollectionReference reviewCollection =
      FirebaseFirestore.instance.collection('reviews');

  Future<String> addUser(BaseUser user) async {
    try {
      await userCollection.doc(user.uid).set(user.toMap());
    } catch (e) {
      return ("Utilizatorul nu a putut fi inregistrat in baza de date.");
    }
    return "success";
  }

  Future<BaseUser?> getCurrentUser(uid) async {
    try {
      final document = await userCollection.doc(uid);
      final DocumentSnapshot snapshot = await document.get();
      Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
      final BaseUser? user = BaseUser.fromMap(map);
      return user;
    } catch (e) {
      return null;
    }
  }
}
