import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

class RootController extends GetxController {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> stores = [];
  Stream<QuerySnapshot>? userStream;
  bool userExists = false;

  Future<void> fetchStores() async {
    try {
      final res = await firestore.collection('store').get();
      if (res.docs.isNotEmpty) {
        stores = res.docs;
      }
    } on Exception catch (e) {
      Get.defaultDialog(title: '연결 오류', middleText: '서버에서 데이터를 받아오지 못함', barrierDismissible: true);
      print(e);
    }
  }

  Future<bool> fetchUser() async {
    if (auth.currentUser == null) {
      userStream = null;
      userExists = false;
    } else {
      try {
        final res = firestore.collection('user').where('uid', isEqualTo: auth.currentUser?.uid).snapshots();
        userStream = res;
        userExists = true;
      } on Exception catch (e) {
        print(e);
        userStream = null;
        userExists = false;
      }
    }
    return userExists;
  }


  @override
  void onInit() {
    super.onInit();
    fetchStores();
    fetchUser();
  }
}