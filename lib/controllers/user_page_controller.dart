import 'package:get/get.dart';

class UserPageController extends GetxController {
  bool isLoggedIn;

  UserPageController({required this.isLoggedIn});

  setIsLoggedIn(bool isLoggedIn) {
    this.isLoggedIn = isLoggedIn;
    update();
  }
}