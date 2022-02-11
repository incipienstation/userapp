import 'package:flutter/material.dart';
import 'package:userapp/widget/bottom_navigation_bar.dart';
import 'package:get/get.dart';
import '../home.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.to(() => MainPage(), transition: Transition.noTransition);
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff555555),
        ),
        body: Center(
          child: Text('마이페이지', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1,),
      ),
    );
  }
}
