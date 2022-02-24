import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final List<String> favoriteStoreIdList;

  User({required this.uid, required this.favoriteStoreIdList});

  factory User.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return User(
      uid: doc['uid'],
      favoriteStoreIdList: List<String>.from(doc['favoriteStoreIdList']),
    );
  }
}