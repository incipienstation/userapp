import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controller/category_controller.dart';
import 'package:userapp/controller/root_controller.dart';
import 'package:userapp/widget/bottom_navigation_bar.dart';
import 'package:userapp/widget/button_shopping_bag.dart';
import './all_pages.dart';


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
            floatingActionButton: ShoppingBagButton(),
            appBar: AppBar(title: Text('YAM', style: TextStyle(fontSize: 28),), automaticallyImplyLeading: false,),
            body: CategoryGrid(),
            bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 2,),
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
                height: 350,
                color: Colors.orange,
                child: Center(child: Text('준비중입니다.')),
              ),
            )
          ],
    );
  }
}
