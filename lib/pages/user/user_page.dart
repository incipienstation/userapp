import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:userapp/controllers/user_controller.dart';
import 'package:userapp/pages/auth/login_page.dart';
import 'package:userapp/widgets/bottom_navigation_bar.dart';
import 'package:get/get.dart';
import '../home.dart';

final auth = FirebaseAuth.instance;

class MyPage extends StatelessWidget {
  MyPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.off(() => Home(), transition: Transition.noTransition);
        return Future(() => false);
      },
      child: GetBuilder<UserController>(
        init: UserController(isLoggedIn: auth.currentUser?.uid != null ? true : false),
        builder: (_) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xff555555),
                title: Text('내정보'),
                actions: [
                  IconButton(
                    icon: _.isLoggedIn
                        ? Icon(Icons.logout)
                        : Icon(Icons.login),
                    onPressed: () {
                      if (_.isLoggedIn) {
                        Get.defaultDialog(
                          titleStyle: TextStyle(
                            fontSize: 0,
                          ),
                          titlePadding: EdgeInsets.all(2),
                          middleText: '로그아웃 하시겠습니까?',
                          actions: [
                            TextButton(
                              onPressed: () {
                                auth.signOut();
                                _.setIsLoggedIn(false);
                                Get.back();
                              },
                              child: Text('확인'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('취소'),
                            ),
                          ],
                        );
                      } else {
                        Get.to(() => LoginPage());
                      }
                    },
                  ),
                ],
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    _.isLoggedIn
                        ? '${auth.currentUser?.email}'
                        : '로그인 필요',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              bottomNavigationBar: CustomBottomNavigationBar(
                currentIndex: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}
