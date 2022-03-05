import 'package:get/get.dart';

class MenuController extends GetxController {
  int quantity = 1;

  void setQuantity(bool plus) {
    if (plus) {
      quantity++;
    } else {
      quantity--;
    }
    update();
  }
}