import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.red,
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      secondaryHeaderColor: isDarkTheme ? Colors.black : Colors.white,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.red,
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        accentColor: Colors.red,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ).copyWith(
        primary: Colors.red,
        secondary: Colors.red,
      ),
      appBarTheme: AppBarTheme(
        color: isDarkTheme ? Colors.black : Colors.red,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
      ),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: isDarkTheme
          ? Color.fromARGB(255, 24, 24, 24)
          : const Color(0xffF1F5FB),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        elevation: 0,
      ),
      shadowColor: isDarkTheme
          ? Color.fromARGB(255, 45, 45, 45)
          : Color.fromARGB(255, 219, 219, 219),
    );
  }
}
