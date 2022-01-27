import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controller/root_controller.dart';
import 'stores.dart';
import 'order.dart';
import 'mypage.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RootController());
    return GetBuilder<RootController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text('YAM'), centerTitle: true, backgroundColor: Colors.orange,),
          body: IndexedStack(
            index: controller.rootPageIndex,
            children: [
              MyPage(),
              StoreListNavigation(),
              OrderPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.rootPageIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: (i){
              controller.changeRootPageIndex(i);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.face_outlined),
                label: "내정보",
                activeIcon: Icon(Icons.face),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_outlined),
                label: "홈",
                activeIcon: Icon(Icons.menu_book),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart_outlined),
                label: "주문내역",
                activeIcon: Icon(Icons.add_shopping_cart)
              ),
            ],
          ),
        );
      }
    );
  }
}