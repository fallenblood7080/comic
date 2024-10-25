import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.black
    ),
    dividerColor: Colors.black87,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
     titleTextStyle: TextStyle(color: Colors.white,fontSize: 20),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      
    )
  );}