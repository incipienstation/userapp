import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:userapp/models/menu.dart';
import 'package:userapp/models/store.dart';
import 'package:userapp/models/user.dart' as user_class;

final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

class StoreController extends GetxController {
  late Store store;
  late user_class.User user;
  List<Menu> menuList = [];
  late List<String> favoriteStoreIdList;
  late List<String> favoriteUidList;
  String? userDocId;
  final String storeDocId;
  late bool isFavorite;

  StoreController({required this.storeDocId});

  @override
  void onInit() {
    super.onInit();
    _verifyUser();
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
    _updateStore();
    if (userDocId != null) {
      _updateUser();
    }
    super.onClose();
  }

  Future<bool> fetchStore(String storeDocId) async {
    try {
      final res = await firestore.collection('store').doc(storeDocId).get();
      if (res.exists) {
        store = Store.fromDoc(res);
        favoriteUidList = store.favoriteUidList;
        return true;
      }
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> fetchMenus(String storeDocId) async {
    try {
      final res = await firestore.collection('store').doc(storeDocId).collection('menu').get();
      if (res.docs.isNotEmpty) {
        List<Menu> menus = [];
        for (var menu in res.docs) {
          menus.add(Menu.fromDoc(menu));
        }
        menuList = menus;
        return true;
      }
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }

  Future<int> _fetchUser() async {
    if (auth.currentUser == null) {
      isFavorite = false;
      return 0;
    } else {
      try {
        final res = await firestore.collection('user').where('uid', isEqualTo: auth.currentUser?.uid).get();
        if (res.docs.isNotEmpty) {
          user = user_class.User.fromDoc(res.docs[0]);
          favoriteStoreIdList = user.favoriteStoreIdList;
          userDocId = res.docs[0].id;
          isFavorite = user.favoriteStoreIdList.contains(storeDocId);
          return 1;
        }
        return -1;
      } on Exception catch (e) {
        print(e);
        return -1;
      }
    }
  }

  _verifyUser() async {
    int res = await _fetchUser();
    if (res == -1) {
      Get.defaultDialog();
    }
  }

  Future<void> _updateStore() {
    return firestore.collection('store')
        .doc(storeDocId)
        .update({'favoriteUidList': favoriteUidList})
        .then((value) => print('store update success'))
        .catchError((error) => print('user update fail'));
  }
  
  Future<void> _updateUser() async {
    return firestore.collection('user')
        .doc(userDocId)
        .update({'favoriteStoreIdList': favoriteStoreIdList})
        .then((value) => print('user update success'))
        .catchError((error) => print('user update fail'));
  }


  bool onTriggerOffset = false;
  final scrollController = ScrollController();
  final double triggerOffset = 300;

  _setonTriggerOffset(bool onTriggerOffset) {
    this.onTriggerOffset = onTriggerOffset;
    update();
  }

  setIsFavorite() {
    isFavorite = !isFavorite;
    update();
  }

  setFavorite() {
    if (!isFavorite) {
      favoriteUidList.add(auth.currentUser!.uid);
      favoriteStoreIdList.add(storeDocId);
    } else {
      favoriteUidList.remove(auth.currentUser!.uid);
      favoriteStoreIdList.remove(storeDocId);
    }
    update();
  }
}