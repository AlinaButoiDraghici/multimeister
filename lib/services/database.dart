import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multimeister/models/base_user.dart';
import 'package:multimeister/models/meister_model.dart';

import '../models/work_model.dart';

class DatabaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference meisterCollection =
      FirebaseFirestore.instance.collection('meisters');
  final CollectionReference<Map<String, dynamic>> workItemCollection =
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

  Future<String> addMeister(Meister meister) async {
    try {
      await meisterCollection.doc(meister.uid).set(meister.toMap());
    } catch (e) {
      return ("Utilizatorul nu a putut fi inregistrat in baza de date.");
    }
    return "success";
  }

  Future<String> addWork(Work work) async {
    try {
      await workItemCollection.doc(work.uid).set(work.toMap());
      await meisterCollection
          .doc(work.meisterUid)
          .update({"workList": work.uid});
    } catch (e) {
      return ("Lucrarea nu a putut fi inregistrata in baza de date.");
    }
    return "success";
  }

  Work _fromDocumentSnapshotToWork(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data();
    return Work(
      uid: doc.id,
      meisterUid: (data['meisterUid'] ?? '') as String,
      meisterName: (data['meisterName'] ?? '') as String,
      meisterCity: (data['meisterCity'] ?? '') as String,
      meisterPhone: (data['meisterPhone'] ?? '') as String,
      rating: data['rating'] as double?,
      price: (data['price'] ?? 0) as double,
      title: (data['title'] ?? '') as String,
      label: (data['label'] ?? '') as String,
      description: (data['description'] ?? '') as String,
      images: data['images'] as List<String>?,
    );
  }

  Future<List<Work>> getAllWorks() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await workItemCollection.get();
    final workList = querySnapshot.docs
        .map((doc) => _fromDocumentSnapshotToWork(doc))
        .toList();
    return workList;
  }

  Future<BaseUser?> getCurrentUser(uid) async {
    try {
      final document = userCollection.doc(uid);
      final DocumentSnapshot snapshot = await document.get();
      Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
      final BaseUser? user = BaseUser.fromMap(map);
      return user;
    } catch (e) {
      return null;
    }
  }
}
