import 'package:flutter/material.dart';

class AppTheme {
  // App light theme
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.pink,
    );
  }

  // App dark theme
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.pink,
    );
  }
}
