import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:userapp/models/store.dart';

class StoreController extends GetxController {
  double offset = 0;
  bool onTriggerOffset = false;
  final scrollController = ScrollController();
  final double triggerOffset = 300;

  _setonTriggerOffset(bool onTriggerOffset) {
    this.onTriggerOffset = onTriggerOffset;
    update();
  }

  setOffset(double offset) {
    this.offset = offset;
    // update();
  }

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

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.offset > triggerOffset) {
        _setonTriggerOffset(true);
      } else {
        _setonTriggerOffset(false);
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}