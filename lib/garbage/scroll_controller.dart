import 'package:get/get.dart';

class ScrollPositionController extends GetxController {
  List<double> scrollPositionList = [];
  int len;
  ScrollPositionController({required this.len});


  @override
  void onInit() {
    for(int i = 0; i < len; i++) {
      scrollPositionList.add(0.0);
    }
    super.onInit();
  }

  setScrollPosition({required int index, required double position}) {
    scrollPositionList[index] = position;
  }

  double getScrollPosition({required int index}) {
    return scrollPositionList[index];
  }
}