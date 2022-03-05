import 'package:flutter/material.dart';
import 'package:userapp/pages/order/shopping_basket_page.dart';
import 'package:get/get.dart';

class ShoppingBasketButton extends StatelessWidget {
  final bool display;
  const ShoppingBasketButton({Key? key, required this.display}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (display) {
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
    } else {
      return SizedBox.shrink();
    }
  }
}
