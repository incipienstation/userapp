import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  String email = '';
  String password = '';

  setEmail(String text) {
    email = text;
  }

  setPassword(String text) {
    password = text;
    update();
  }

  List<bool> isVisibleList = [false, false, false];

  setVisibility(int key) {
    isVisibleList[key] = !isVisibleList[key];
    update();
  }

  bool duplicatedEmailErrorOccurred = false;
  bool userNotFoundErrorOccurred = false;
  bool wrongPasswordErrorOccurred = false;
  bool tooManyRequestsErrorOccurred = false;

  setErrorWithType(bool isErrorOccurred, int type) {
    switch (type) {
      case 0:
        duplicatedEmailErrorOccurred = isErrorOccurred;
        break;
      case 1:
        userNotFoundErrorOccurred = isErrorOccurred;
        break;
      case 2:
        wrongPasswordErrorOccurred = isErrorOccurred;
        break;
      case 3:
        tooManyRequestsErrorOccurred = isErrorOccurred;
        break;
      default:
        if (isErrorOccurred) {
          update();
        }
    }
  }
}
