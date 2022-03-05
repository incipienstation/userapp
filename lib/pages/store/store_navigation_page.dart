import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/category_controller.dart';
import 'package:userapp/controllers/root_controller.dart';
import 'package:userapp/controllers/shopping_basket_controller.dart';
import 'package:userapp/widgets/custom_back_button.dart';
import 'package:userapp/widgets/custom_list_tile.dart';
import 'package:userapp/widgets/shopping_basket_button.dart';

class StoreListNavigation extends StatelessWidget {
  StoreListNavigation({Key? key}) : super(key: key);

  final categoryController = Get.find<CategoryController>();
  final rootController = Get.find<RootController>();
  final shoppingBasketController = Get.find<ShoppingBasketController>();
  final int index = Get.arguments;

  @override
  Widget build(BuildContext context) {
    categoryController.setCurrentIndex(index);

    PageController tabBarController = PageController(
      initialPage: categoryController.currentIndex,
      keepPage: true,
      viewportFraction: 0.22
    );

    PageController pageViewController = PageController(
      initialPage: categoryController.currentIndex,
      keepPage: true
    );

    ScrollController listViewController = ScrollController();

    return GetBuilder<CategoryController>(
      builder: (_) {
        return SafeArea(
          child: Scaffold(
            floatingActionButton: GetBuilder<ShoppingBasketController>(
              builder: (_) => ShoppingBasketButton(display: _.isNotEmpty()),
            ),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(120),
              child: AppBar(
                title: Text(categoryController.categoryList[categoryController.currentIndex]),
                leading: CustomBackButton(),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: Container(
                    height: 50,
                    color: Colors.white,
                    child: PageView.builder(
                      controller: tabBarController,
                      pageSnapping: false,
                      itemCount: categoryController.categoryList.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () async {
                            pageViewController.jumpToPage(index);
                            await tabBarController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
                          },
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 45,
                                  child: Center(
                                    child: Text(categoryController.categoryList[index],
                                      style: index == categoryController.currentIndex ? categoryController.textStyleList[1]: categoryController.textStyleList[0],
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: index == categoryController.currentIndex ? Colors.black : Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ),
              )
            ),
            body: PageView.builder(
              controller: pageViewController,
              allowImplicitScrolling: true,
              onPageChanged: (index) async {
                await categoryController.setCurrentIndex(index);
                await tabBarController.animateToPage(index, duration: Duration(seconds: 1), curve: Curves.ease);
              },
              itemBuilder: (_, i) {
                List<QueryDocumentSnapshot<Map<String, dynamic>>> storesWithinCategory = rootController.stores.where((element) => element['category'] == categoryController.categoryList[i] ? true : false).toList();
                return ListView.builder(
                  key: PageStorageKey<int>(i),
                  controller: listViewController,
                  itemCount: storesWithinCategory.length,
                  itemBuilder: (_, j) {
                    return CustomListTile(listViewIndex: j, stores: storesWithinCategory,);
                  }
                );
              },
              itemCount: categoryController.categoryList.length,
            ),
          ),
        );
      }
    );
  }
}