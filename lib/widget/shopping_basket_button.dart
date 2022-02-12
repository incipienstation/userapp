import 'package:flutter/material.dart';
import 'package:userapp/page/order/shopping_basket.dart';
import 'package:get/get.dart';

class ShoppingBasketButton extends StatelessWidget {
  const ShoppingBasketButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.redAccent,
      onPressed: (){
        Get.to(() => ShoppingBasketPage());
      },
      child: Icon(Icons.shopping_basket),
    );
  }
}
