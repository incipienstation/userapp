import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/category_controller.dart';
import 'package:userapp/controllers/root_controller.dart';
import 'package:userapp/pages/store/store_navigation_page.dart';
import 'package:userapp/widgets/bottom_navigation_bar.dart';
import 'package:userapp/widgets/shopping_basket_button.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(
      builder: (_) {
        return WillPopScope(
          onWillPop: () {
            return Future(() => false);
          },
          child: Scaffold(
            floatingActionButton: ShoppingBasketButton(),
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

  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(15),
          sliver: SliverGrid(
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
                            borderRadius: BorderRadius.circular(42),
                          )
                        )
                      ),
                      onPressed: () {
                        Get.to(() => StoreListNavigation(), arguments: index);
                      },
                      child: Text(categoryController.categoryList[index],
                        style: TextStyle(color: Colors.black45, fontSize: 13.5),
                        textAlign: TextAlign.center,
                      )
                    ),
                  ),
                )
              ),
              childCount: categoryController.categoryList.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.all(20),
            height: 350,
            color: Colors.orange,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('준비중입니다')
              ],
            )
          ),
        )
      ],
    );
  }
}