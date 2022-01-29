import 'package:flutter/material.dart';
import 'package:userapp/page/order_page/shopping_bag.dart';
import 'package:get/get.dart';

class ShoppingBagButton extends StatelessWidget {
  const ShoppingBagButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.redAccent,
      onPressed: (){
        Get.to(() => ShoppingBagPage());
      },
      child: Icon(Icons.shopping_basket),
    );
  }
}
