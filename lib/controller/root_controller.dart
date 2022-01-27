import 'package:get/get.dart';

class RootController extends GetxController {
  int rootPageIndex = 1;

  changeRootPageIndex(int index) {
    rootPageIndex = index;
    update();
  }

  setHome() {
    rootPageIndex = 1;
    update();
  }
}