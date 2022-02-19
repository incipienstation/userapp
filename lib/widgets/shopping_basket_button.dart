import 'package:flutter/material.dart';
import 'package:userapp/pages/order/shopping_basket.dart';
import 'package:get/get.dart';

class ShoppingBasketButton extends StatelessWidget {
  const ShoppingBasketButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.redAccent,
      onPressed: () {
        Get.to(
          () => ShoppingBasketPage(),
          transition: Transition.downToUp,
          duration: Duration(milliseconds: 600),
          fullscreenDialog: true,
        );
      },
      child: Icon(Icons.shopping_basket),
    );
  }
}
