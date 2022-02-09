import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/widget/button_shopping_basket.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ShoppingBasketButton(),
      appBar: AppBar(
        title: Text(Get.arguments),
      ),
    );
  }
}
