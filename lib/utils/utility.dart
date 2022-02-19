class Utility {
  static String intToStringWithFormat(int number) {
    String str = number.toString();
    String newStr = '';
    int cnt = 1;

    for (int i = 0; i < str.length; i++) {
      newStr += str[str.length - i - 1];
      if (cnt % 3 == 0 && i != str.length - 1) {
        newStr += ',';
      }
      cnt++;
    }
    return newStr.split('').reversed.join('');
  }
}
