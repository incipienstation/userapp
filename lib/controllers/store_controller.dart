import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:userapp/models/store.dart';

class StoreController extends GetxController {

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> fetchMenus(Store store) async {
    try {
      final res = await store.menu!.get();
      if (res.docs.isNotEmpty) {
        return res.docs;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}