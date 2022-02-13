import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/pages/home.dart';
import 'package:userapp/pages/order/order_page.dart';
import 'package:userapp/pages/store/favorite_page.dart';
import 'package:userapp/pages/user/user_page.dart';
import 'package:userapp/pages/user/question_page.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({Key? key, required this.currentIndex}) : super(key: key);
  final currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      key: PageStorageKey<String>('default'),
      onTap: (i){
        switch (i) {
        case 0:
          Get.off(() => QuestionPage(), transition: Transition.fadeIn);
          break;
        case 1:
          Get.off(() => MyPage(), transition: Transition.fadeIn);
          break;
        case 2:
          Get.off(() => Home(), transition: Transition.fadeIn);
          break;
        case 3:
          Get.off(() => FavoritePage(), transition: Transition.fadeIn);
          break;
        case 4:
          Get.off(() => OrderPage(), transition: Transition.fadeIn);
          break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.question_answer_outlined),
          label: "문의",
          activeIcon: Icon(Icons.question_answer),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.face_outlined),
          label: "내정보",
          activeIcon: Icon(Icons.face),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          label: "홈",
          activeIcon: Icon(Icons.menu_book_rounded),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: "찜",
          activeIcon: Icon(Icons.favorite),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: "주문내역",
            activeIcon: Icon(Icons.receipt_long)
        ),
      ],
    );
  }
}
