import 'package:flutter/material.dart';
import 'package:userapp/widgets/custom_close_button.dart';

class ShoppingBasketPage extends StatelessWidget {
  const ShoppingBasketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '장바구니',
          style: TextStyle(color: Colors.black),
        ),
        leading: CustomCloseButton(),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }
}
