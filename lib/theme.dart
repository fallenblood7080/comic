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
  );}