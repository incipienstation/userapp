import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controller/category_controller.dart';
import 'package:userapp/controller/root_controller.dart';
import 'store_page/stores.dart';
import 'order_page/order.dart';
import 'user_page/mypage.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(RootController());
    return GetBuilder<RootController>(
      builder: (_) {
        return WillPopScope(
          onWillPop: () {
            return Future(() => false);
          },
          child: Scaffold(
            appBar: AppBar(title: Text('YAM'), centerTitle: true, backgroundColor: Colors.red,),
            body: CategoryGrid(),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 1,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              onTap: (i){
                if (i == 0) {
                  Get.to(() => MyPage());
                }
                if (i == 2) {
                  Get.to(() => OrderPage());
                }
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
          ),
        );
      }
    );
  }
}

class CategoryGrid extends StatelessWidget {
  CategoryGrid({Key? key}) : super(key: key);

  final controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid(
          delegate: SliverChildBuilderDelegate((_, index) =>
            SizedBox(
              child: Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        )
                      )
                    ),
                    onPressed: () {
                      Get.to(StoreListNavigation(), arguments: index);
                    },
                    child: Text(controller.categoryList[index],
                      style: TextStyle(color: Colors.black45, fontSize: 13.5),
                      textAlign: TextAlign.center,
                    )
                  ),
                ),
              )
            ),
            childCount: controller.categoryList.length,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            ),
          ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                height: 200,
                color: Colors.orange,
                child: Center(child: Text('준비중입니다.')),
              ),
            )
          ],
    );
  }
}
