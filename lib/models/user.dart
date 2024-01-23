import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  String? nickname;
  final List<String> favoriteStoreIdList;

  User({
    required this.uid,
    required this.favoriteStoreIdList,
    this.nickname,
  });

  factory User.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return User(
      uid: doc['uid'],
      favoriteStoreIdList: List<String>.from(doc['favoriteStoreIdList']),
    );
  }
}
