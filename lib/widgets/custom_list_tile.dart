import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/category_controller.dart';
import 'package:userapp/controllers/root_controller.dart';
import 'package:userapp/models/store.dart';
import 'package:userapp/pages/store/store_page.dart';
import 'package:userapp/utils/utility.dart';

final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

class CustomListTile extends StatelessWidget {
  final int listViewIndex;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> stores;

  CustomListTile({
    Key? key, required this.listViewIndex, required this.stores,
  }) : super(key: key);

  final categoryController = Get.find<CategoryController>();
  final rootController = Get.find<RootController>();

  @override
  Widget build(BuildContext context) {
    Store store = Store.fromDoc(stores[listViewIndex]);

    return GestureDetector(
      onDoubleTap: () {
        print(stores[listViewIndex].reference.id);
      },
      onTap: (){
        Get.to(
          () => StorePage(),
          transition: Transition.rightToLeftWithFade,
          arguments: stores[listViewIndex].reference.id,
          duration: Duration(milliseconds: 500),
          popGesture: false,
        );
      },
      child: Container(
        height: 130,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(width: 2, color: Color(0xffdddddd)))
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 120,
              color: Colors.greenAccent,
              child: Center(
                child: Text(
                  '이미지 준비중',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                color: Colors.cyan,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.name,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),
                    ),
                    Text(
                      '대표메뉴 준비중',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal,),
                    ),
                    Text(
                      '최소주문금액 ${Utility.intToStringWithFormat(store.minDeliveryAmount)}원',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal,),
                    ),
                    Text(
                      '배달요금 ${Utility.intToStringWithFormat(store.minDeliveryAmount)}원',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}