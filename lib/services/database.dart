import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multimeister/models/base_user.dart';

class DatabaseService{
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference meisterCollection = FirebaseFirestore.instance.collection('meisters');
  final CollectionReference workItemCollection = FirebaseFirestore.instance.collection('workItems');
  final CollectionReference reviewCollection = FirebaseFirestore.instance.collection('reviews');
}