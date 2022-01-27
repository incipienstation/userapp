import 'package:get/get.dart';

class RootController extends GetxController {
  int rootPageIndex = 0;

  changeRootPageIndex(int index) {
    rootPageIndex = index;
    update();
  }
}