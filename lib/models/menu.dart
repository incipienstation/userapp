import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  final String id;
  final String name;
  final int price;

  Menu({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Menu.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Menu(
      id: doc.id,
      name: doc['name'],
      price: doc['price'],
    );
  }
}
