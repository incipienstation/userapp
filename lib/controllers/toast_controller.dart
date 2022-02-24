import 'package:get/get.dart';

class ToastController extends GetxController {
  bool isActive = false;

  setIsActive() {
    isActive = !isActive;
  }

  bool visible = false;

  setVisible() {
    visible = !visible;
    update();
  }
}