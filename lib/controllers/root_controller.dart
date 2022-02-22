import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> stores = [];

  Future<void> fetchStores() async {
    try {
      final res = await FirebaseFirestore.instance.collection('store').get();
      if (res.docs.isNotEmpty) {
        stores = res.docs;
      }
    } on Exception catch (e) {
      Get.defaultDialog(title: '연결 오류', middleText: '서버에서 데이터를 받아오지 못함', barrierDismissible: true);
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchStores();
  }


  bool isPushed = false;

  setIsPushed() {
    isPushed = !isPushed;
    update();
  }

  bool isActive = false;

  setIsActive() {
    isActive = !isActive;
  }

  bool visible = false;

  setVisible() {
    visible = !visible;
    update();
  }
}