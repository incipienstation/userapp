import 'package:flutter/material.dart';

var theme = ThemeData(
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.white,
      letterSpacing: 1.3,
    ),
    centerTitle: true,
    backgroundColor: Colors.redAccent,
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.redAccent,
    unselectedItemColor: Colors.grey,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.redAccent,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.redAccent,
    ),
  ),
);
