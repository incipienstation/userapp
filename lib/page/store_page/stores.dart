import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controller/category_controller.dart';

class StoreListNavigation extends StatelessWidget {
  StoreListNavigation({Key? key}) : super(key: key);

  final controller = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    controller.setCurrentIndex(Get.arguments);

    PageController pageController1 = PageController(
      initialPage: controller.currentIndex,
      keepPage: true,
      viewportFraction: 0.25
    );

    PageController pageController2 = PageController(
      initialPage: controller.currentIndex,
      keepPage: true
    );

    return GetBuilder<CategoryController>(
      builder: (_) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: AppBar(
              title: Text(controller.categoryList[controller.currentIndex]),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: Container(
                  height: 50,
                  color: Colors.white,
                  child: PageView.builder(
                    controller: pageController1,
                    pageSnapping: false,
                    itemCount: controller.categoryList.length,
                    itemBuilder: (_, index) {
                      return Container(
                        color: Colors.white,
                        child: TextButton(
                          onPressed: () async {
                            pageController2.jumpToPage(index);
                            pageController1.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
                          },
                          child: Text(controller.categoryList[index],
                            style: index == controller.currentIndex ? controller.textStyleList[1]: controller.textStyleList[0],
                            textAlign: TextAlign.center,
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
            controller: pageController2,
            onPageChanged: (index) async {
              await controller.setCurrentIndex(index);
              pageController1.animateToPage(index, duration: Duration(seconds: 1), curve: Curves.ease);
            },
            itemBuilder: (_, i) {
              return Container(
                color: Colors.white30,
                child: Center(
                  child: Text('${controller.categoryList[i]}\n음식점 목록',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
            itemCount: controller.categoryList.length,
          ),
        );
      }
    );
  }
}