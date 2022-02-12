import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:userapp/controller/category_controller.dart';
import 'package:userapp/controller/root_controller.dart';
import 'package:userapp/page/store/store_navigation_page.dart';
import 'package:userapp/widget/bottom_navigation_bar.dart';
import 'package:userapp/widget/shopping_basket_button.dart';
import 'auth/login_page.dart';


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
            appBar: AppBar(title: Text('YAM', style: TextStyle(fontSize: 28),), automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Get.offAll(() => LoginPage(), transition: Transition.fade, duration: Duration(milliseconds: 1000));
                  },
                ),
              ],
            ),
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
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            height: 350,
            color: Colors.orange,
            child: Center(
              child: Text('준비중입니다'),
            ),
          ),
        )
      ],
    );
  }
}
