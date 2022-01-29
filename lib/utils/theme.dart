import 'package:flutter/material.dart';

var theme = ThemeData(
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white70),
    centerTitle: true,
    backgroundColor: Colors.redAccent
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold
    )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.redAccent,
    unselectedItemColor: Colors.grey,
  )
);