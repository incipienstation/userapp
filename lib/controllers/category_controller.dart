import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CategoryController extends GetxController {
  final categoryList = [
    '카페\u2022디저트',
    '분식',
    '패스트푸드',
    '한식',
    '치킨',
    '중식',
    '피자',
    '일식',
    '족발\u2022보쌈',
  ];

  int currentIndex = 0;


  setCurrentIndex(int i) {
    currentIndex = i;
    update();
  }

  var textStyleList = [
    TextStyle(color: Colors.grey, fontSize: 12),
    TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)
  ];

}