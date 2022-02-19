import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final String name;
  final String address;
  final String category;
  final int minDeliveryAmount;
  final CollectionReference<Map<String, dynamic>>? menu;

  Store({required this.name, required this.address, required this.category, required this.minDeliveryAmount, this.menu});

  factory Store.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Store(
      name: doc['name'],
      address: doc['address'],
      category: doc['category'],
      minDeliveryAmount: doc['minDeliveryAmount'],
      menu: doc.reference.collection('menu'),
    );
  }
}