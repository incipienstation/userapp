import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controller/category_controller.dart';
import 'package:userapp/page/all.dart';

class StoreListNavigation extends StatelessWidget {
  StoreListNavigation({Key? key}) : super(key: key);

  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    categoryController.setCurrentIndex(Get.arguments);

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
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: AppBar(
              title: Text(categoryController.categoryList[categoryController.currentIndex]),
              centerTitle: true,
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
              return ListView.builder(
                key: PageStorageKey<int>(i),
                controller: listViewController,
                itemCount: 15,
                itemBuilder: (_, j) {
                  return GestureDetector(
                    onDoubleTap: () {

                    },
                    onTap: (){
                      Get.to(() => StorePage(), arguments: '${categoryController.categoryList[i]} ${j + 1}');
                    },
                    child: Container(
                      key: PageStorageKey<String>('$i/$j'),
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(bottom: BorderSide(width: 2, color: Color(0xffdddddd)))
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(color: Colors.greenAccent,
                              child: Center(
                                child: Text('${categoryController.categoryList[i]} ${j + 1}',
                                  style: TextStyle(
                                    fontSize: 13
                                  ),
                                )
                              ),
                            ),
                            flex: 3,
                          ),
                          Flexible(
                            child: Container(color: Colors.cyan,),
                            flex: 7,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              );
            },
            itemCount: categoryController.categoryList.length,
          ),
        );
      }
    );
  }
}