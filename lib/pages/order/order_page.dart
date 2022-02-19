import 'package:flutter/material.dart';
import 'package:userapp/widgets/bottom_navigation_bar.dart';
import 'package:get/get.dart';
import '../home.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.off(() => Home(), transition: Transition.noTransition);
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff555555),
        ),
        body: Center(
          child: Text('주문내역', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 4,),
      ),
    );
  }
}
