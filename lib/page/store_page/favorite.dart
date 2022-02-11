import 'package:flutter/material.dart';
import 'package:userapp/widget/bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:userapp/widget/button_shopping_basket.dart';
import '../home.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.to(() => MainPage(), transition: Transition.noTransition);
        return Future(() => false);
      },
      child: Scaffold(
        floatingActionButton: ShoppingBasketButton(),
        appBar: AppBar(
          backgroundColor: Color(0xff555555),
        ),
        body: Center(
          child: Text('찜', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 3,),
      ),
    );
  }
}
