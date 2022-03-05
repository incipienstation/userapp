import 'package:get/get.dart';

class UserController extends GetxController {
  bool isLoggedIn;

  UserController({required this.isLoggedIn}) {
    update();
  }

  setIsLoggedIn(bool isLoggedIn) {
    this.isLoggedIn = isLoggedIn;
    update();
  }
}