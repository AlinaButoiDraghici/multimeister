import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multimeister/models/base_user.dart';
import 'package:multimeister/models/meister_model.dart';
import 'package:multimeister/models/review_model.dart';

import '../models/work_model.dart';

class DatabaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference meisterCollection =
      FirebaseFirestore.instance.collection('meisters');
  final CollectionReference<Map<String, dynamic>> workItemCollection =
      FirebaseFirestore.instance.collection('workItems');
  final CollectionReference<Map<String, dynamic>> reviewCollection =
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
    Work work = Work(
      uid: doc.id,
      meisterUid: (data['meisterUid'] ?? '') as String,
      meisterName: (data['meisterName'] ?? '') as String,
      meisterCity: (data['meisterCity'] ?? '') as String,
      meisterPhone: (data['meisterPhone'] ?? '') as String,
      rating: (data['rating'] ?? 0.0) as double,
      price: (data['price'] ?? 0) as double,
      title: (data['title'] ?? '') as String,
      label: (data['label'] ?? '') as String,
      description: (data['description'] ?? '') as String,
      images: data['images'] as List<String>?,
    );

    work.updateReviews();

    return work;
  }

  Future<List<Work>> getAllWorks() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await workItemCollection.get();
    final workList = querySnapshot.docs
        .map((doc) => _fromDocumentSnapshotToWork(doc))
        .toList();
    return workList;
  }

  Future<List<Work>> getMeisterWorks(meisterID) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await workItemCollection.where("workItemUid", isEqualTo: meisterID).get();
    final workList = querySnapshot.docs
        .map((doc) => _fromDocumentSnapshotToWork(doc))
        .toList();
    return workList;
  }

   Future<double> getMeisterScore(meisterID) async {
    List<Work> meisterWorkList = await getMeisterWorks(meisterID);
    double sum = 0;
    for (Work work in meisterWorkList) {
      sum += await getWorkItemScore(work.uid);
    }
    sum /= meisterWorkList.length;
    return sum;
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

  Future<Meister?> getMeister(uid) async {
    try {
      final document = meisterCollection.doc(uid);
      final DocumentSnapshot snapshot = await document.get();
      Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
      final Meister? meister = Meister.fromMap(map);

      if (meister != null) {
        double meisterScore = 0;
        for (String workItemID in meister.workList) {
          meisterScore += await getWorkItemScore(workItemID);
        }
        meisterScore /= meister.workList.length;
        meister.rating = meisterScore;
      }

      return meister;
    } catch (e) {
      return null;
    }
  }

  Future<String> addReview(Review review) async {
    try {
      await reviewCollection.doc(review.uid).set(review.toMap());
      await workItemCollection
          .doc(review.workItemUid)
          .update({"reviewList": review.uid});
      double newScore = await getWorkItemScore(review.workItemUid);
      await workItemCollection
          .doc(review.workItemUid)
          .update({"rating": newScore});
      double meisterScore = await getMeisterScore(review.meisterUid);
      await meisterCollection
          .doc(review.meisterUid)
          .update({"rating": meisterScore});
    } catch (e) {
      return ("Recenzia nu a putut fi inregistrata in baza de date.");
    }
    return "success";
  }

  Future<Review?> getReview(reviewID) async {
    try {
      final document = reviewCollection.doc(reviewID);
      final DocumentSnapshot snapshot = await document.get();

      Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;

      final Review review = Review.fromMap(map);
      return review;
    } catch (e) {
      return null;
    }
  }

  Future<List<Review>> getWorkItemReviews(workItemID) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await reviewCollection.where("workItemUid", isEqualTo: workItemID).get();
    final reviewList = querySnapshot.docs
        .map((doc) => _fromDocumentSnapshotToReview(doc))
        .toList();
    return reviewList;
  }

  // Future<List<Review>> getWorkItemReviewIDs(workItemID) async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await reviewCollection.where("workItemUid", isEqualTo: workItemID).get();
  //   final reviewIDList = querySnapshot.docs
  //       .map((doc) => _fromDocumentSnapshotToReview(doc).uid)
  //       .toList();
  //   return reviewIDList;
  // }

  Future<double> getWorkItemScore(workItemID) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await reviewCollection.where("workItemUid", isEqualTo: workItemID).get();
    final reviewScoreList = querySnapshot.docs
        .map((doc) => _getReviewListAverage(doc))
        .toList();
    double sum = 0;
    for (double score in reviewScoreList) {
      sum += score;
    }
    sum /= reviewScoreList.length;
    return sum;
  }

  double _getReviewListAverage(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data();
    return (data['rating'] ?? 0) as double;
  }

  Review _fromDocumentSnapshotToReview(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data();
    return Review(
      uid: doc.id,
      meisterUid: (data['meisterUid'] ?? '') as String,
      reviewerUid: (data['reviewerUid'] ?? '') as String,
      reviewerName: (data['reviewerName'] ?? '') as String,
      workItemUid: (data['workItemUid'] ?? '') as String,
      rating: (data['rating'] ?? 0) as double,
    );
  }
}
